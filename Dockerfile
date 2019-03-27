FROM ubuntu:18.04

RUN apt update \
        && apt install -y \
            build-essential \
            clang-7 \
            clang-format-7 \
            cmake \
            curl \
            openssh-server \
            sudo \
            vim \
            whois \
        && rm -rf /var/lib/apt/lists*

RUN sed -i.bak "s;#PasswordAuthentication yes;PasswordAuthentication yes;g" /etc/ssh/sshd_config
RUN mkdir /var/run/sshd

ARG WORKUSR=dev
RUN useradd -m -p `echo "$WORKUSR" | mkpasswd -s -m sha-512` -s /bin/bash $WORKUSR && gpasswd -a $WORKUSR sudo

CMD ["/usr/sbin/sshd", "-D"]

