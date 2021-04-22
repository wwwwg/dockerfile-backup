ARG OS_VER=edge

FROM alpine:${OS_VER}

RUN set -ex && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk add --no-cache lsyncd openssh-client && \
    echo "UserKnownHostsFile /etc/lsyncd/ssh/known_hosts" >> /etc/ssh/ssh_config

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/lsyncd", "-nodaemon", "-log", "scarce", "/etc/lsyncd/main.lua"]
