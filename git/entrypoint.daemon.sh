#!/usr/bin/env sh

readonly data_dir="/data"

getent group inside >/dev/null || \
    addgroup -g ${PGID:-1000} inside 2>/dev/null
getent passwd inside >/dev/null || \
    adduser -D -H -h ${data_dir} -s /sbin/nologin -G inside -u ${PUID:-1000} inside 2>/dev/null

set -eu

chown -R inside:inside ${data_dir}

exec su-exec inside:inside "$@"
