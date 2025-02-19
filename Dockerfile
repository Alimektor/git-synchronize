FROM alpine:latest

RUN apk add --no-cache git bash make pandoc openssh-client mandoc

COPY . /app

RUN cd /app && make install

WORKDIR /app

ENTRYPOINT ["/usr/bin/git", "synchronize"]
