ARG OS_VER=edge

FROM alpine:edge AS build

ARG VER=0.105.1

RUN set -eux && \
    alpineArch="$(apk --print-arch)" && \
        case "${alpineArch##*-}" in \
            aarch64) ARCH="arm64" ;; \
              armv7) ARCH="armv7" ;; \
             x86_64) ARCH="amd64" ;; \
                  *) echo "Unsupported CPU architecture."; exit 1 ;; \
        esac && \
    wget -qO - "http://static.inside.net/software/linux/AdGuardHome/${VER}/AdGuardHome_linux_${ARCH}.tar.gz" | tar -xzf - -C /tmp --strip-components=2

FROM yocents/library:ca-certificates AS lib1
FROM yocents/library:su-exec-alpine AS lib2
FROM yocents/alpine:${OS_VER}

COPY --from=build /tmp/AdGuardHome           /usr/sbin/
COPY --from=lib1  /certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=lib2  /sbin/su-exec              /sbin/

RUN set -ex && \
    apk add --no-cache libcap && \
    setcap 'cap_net_bind_service=+eip' /usr/sbin/AdGuardHome && \
    getcap /usr/sbin/AdGuardHome

VOLUME ["/conf", "/data"]

EXPOSE 53 53/udp 67/udp 68/udp 443 784/udp 853 3000

COPY entrypoint.sh  /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/AdGuardHome", "--no-check-update", "-c", "/conf/AdGuardHome.yaml", "-w", "/data"]
