ARG OS_VER=edge

FROM yocents/library:su-exec-alpine AS lib1
FROM yocents/library:tzdata AS lib2
FROM alpine:${OS_VER}

ENV HISTFILE=/dev/null HISTFILESIZE=0 HISTSIZE=0

COPY --from=lib1 /sbin/su-exec           /sbin/
COPY --from=lib2 /zoneinfo/Asia/Shanghai /etc/localtime

RUN set -ex && \
    echo "Asia/Shanghai" > /etc/timezone && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
