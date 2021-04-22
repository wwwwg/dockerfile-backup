ARG OS_VER=edge

FROM yocents/alpine:${OS_VER}

RUN set -ex && \
    apk add --no-cache git

ENTRYPOINT ["/usr/bin/git"]

CMD ["--help"]
