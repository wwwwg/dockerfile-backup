ARG OS_VER=edge

FROM alpine:${OS_VER}

RUN set -ex && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk add --no-cache samba-server samba-common-tools

EXPOSE 139 445

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/smbd", "-F", "-S", "--no-process-group"]

STOPSIGNAL SIGTERM
