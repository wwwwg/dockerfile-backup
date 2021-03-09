ARG OS_VER=edge

FROM yocents/alpine:${OS_VER}

RUN set -ex && \
    apk add --no-cache --no-scripts aria2

VOLUME ["/conf", "/data"]

EXPOSE 6800 6881 6881/udp

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/aria2c", "--conf-path=/conf/aria2.conf", "--dir=/data", "-q"]
