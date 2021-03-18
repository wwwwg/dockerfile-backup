ARG OS_VER=edge

FROM yocents/alpine:${OS_VER}

RUN set -ex && \
    apk add --no-cache --no-scripts bind

EXPOSE 53 53/udp 953

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "nobody"]
