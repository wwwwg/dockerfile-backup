ARG OS_VER=edge

FROM alpine:${OS_VER} AS build

RUN set -ex && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/' /etc/apk/repositories && \
    apk add --no-cache apcupsd && \
    echo "body > table { margin: 0 auto; }" >> /etc/apcupsd/apcupsd.css && \
    echo "body > div > table { margin: 0 auto; }" >> /etc/apcupsd/apcupsd.css && \
    echo "body > blockquote { width: 320px; margin: 16px auto; }" >> /etc/apcupsd/apcupsd.css

FROM alpine:${OS_VER}

COPY --from=build /etc/apcupsd/apcupsd.css   /etc/apcupsd/
COPY --from=build /etc/apcupsd/multimon.conf /etc/apcupsd/

RUN set -ex && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/' /etc/apk/repositories && \
    apk add --no-cache --no-scripts spawn-fcgi fcgiwrap

RUN set -ex && \
    apk add --no-cache apcupsd-webif && \
    echo 'MONITOR 172.30.20.251 "raspberrypi"' > /etc/apcupsd/hosts.conf
    
EXPOSE 9000

CMD ["/usr/bin/spawn-fcgi", "-n", "-p", "9000", "-u", "xfs", "--", "/usr/bin/fcgiwrap"]
