FROM alpine:latest

RUN apk add --no-cache git openssh bash

RUN adduser -D -s /usr/bin/git-shell git && \
    echo "git:git" | chpasswd && \
    echo "root:root" | chpasswd && \
    mkdir -p /home/git/.ssh && \
    chmod 700 /home/git/.ssh && \
    touch /home/git/.ssh/authorized_keys && \
    chmod 600 /home/git/.ssh/authorized_keys && \
    mkdir -p /home/git/repositories && \
    chown -R git:git /home/git

RUN ssh-keygen -A

RUN mkdir -p /home/git/repositories/test-repo.git && \
    cd /home/git/repositories/test-repo.git && \
    git init --bare --initial-branch=main && \
    chown -R git:git /home/git/repositories

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
