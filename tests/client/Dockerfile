FROM git-synchronize:latest

ENV PAGER=cat

RUN apk add --no-cache git sshpass bash curl

RUN git config --global init.defaultbranch main

WORKDIR /

ENTRYPOINT ["sh", "-c", "echo hi && sleep infinity"]
