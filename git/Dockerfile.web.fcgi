ARG BASE_VER=2.26.3

FROM yocents/git:${BASE_VER}

RUN set -ex && \
    apk add --no-cache --no-scripts spawn-fcgi fcgiwrap

RUN set -ex && \
    apk add --no-cache git-gitweb perl-cgi-fast

VOLUME ["/data"]

COPY gitweb-common.conf /etc/gitweb-common.conf

EXPOSE 9000

CMD ["/usr/bin/spawn-fcgi", "-n", "-p", "9000", "-u", "xfs", "--", "/usr/bin/fcgiwrap"]
