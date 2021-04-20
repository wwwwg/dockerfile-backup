ARG OS_VER=edge

FROM alpine:${OS_VER}

RUN set -ex && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk add --no-cache rsync

ENTRYPOINT ["/usr/bin/rsync"]

CMD ["--help"]
