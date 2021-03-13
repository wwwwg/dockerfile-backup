ARG OS_VER=edge

FROM yocents/builder:alpine AS build

ARG VER=2.72

RUN set -eux && \
    wget -qO - "http://source.inside.net/dnsmasq/dnsmasq-${VER}.tar.xz" | tar -xJf - -C . --strip-components=1 && \
    sed -i 's/TTL_FLOOR_LIMIT 3600/TTL_FLOOR_LIMIT 86400/g' src/config.h && \
    make -s COPTS=-DHAVE_BROKEN_RTC && \
    install -m 755 src/dnsmasq /usr/sbin

FROM alpine:${OS_VER}

COPY --from=build /usr/sbin/dnsmasq /usr/sbin/

EXPOSE 53 53/udp

VOLUME ["/conf"]

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/dnsmasq", "-k", "--conf-file=/conf/dnsmasq.conf", "--clear-on-reload"]
