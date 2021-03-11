ARG OS_VER=edge

FROM yocents/alpine:${OS_VER}

RUN set -ex && \
    apk add --no-cache --no-scripts mosquitto

EXPOSE 1883

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/mosquitto", "-c", "/etc/mosquitto/mosquitto.conf"]
