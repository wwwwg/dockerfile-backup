ARG OS_VER=edge

FROM yocents/builder:alpine AS build

RUN set -ex && \
    git clone --branch master --single-branch git://repos.bendi.net/github/Wind4/vlmcsd.git . && \
    make -s

FROM alpine:${OS_VER}

COPY --from=build /usr/src/bin/vlmcsd /usr/bin/vlmcsd

EXPOSE 1688

USER nobody:nobody

CMD ["/usr/bin/vlmcsd", "-D", "-L", "0.0.0.0", "-e", "-d"]
