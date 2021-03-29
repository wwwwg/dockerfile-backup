ARG OS_VER=edge

FROM yocents/builder:alpine AS build

ARG VER=5.0.12

RUN set -eux && \
    wget -qO - http://source.inside.net/redis/redis-${VER}.tar.gz | tar -xzf - -C . --strip-components=1 && \
    grep -E '^ *createBoolConfig[(]"protected-mode",.*, *1 *,.*[)],$' src/config.c; \
    sed -ri 's!^( *createBoolConfig[(]"protected-mode",.*, *)1( *,.*[)],)$!\10\2!' src/config.c; \
    grep -E '^ *createBoolConfig[(]"protected-mode",.*, *0 *,.*[)],$' src/config.c; \
    make -s BUILD_TLS=yes && \
    make -s PREFIX=/opt/redis install

FROM yocents/alpine:${OS_VER}

COPY --from=build /opt/redis/bin/redis-benchmark /usr/bin/
COPY --from=build /opt/redis/bin/redis-cli       /usr/bin/
COPY --from=build /opt/redis/bin/redis-server    /usr/bin/

RUN set ex && \
    apk add --no-cache libgcc

VOLUME ["/conf", "/data"]

EXPOSE 6379

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/redis-server", "/conf/redis.conf"]
