#!/usr/bin/env sh

readonly conf_dir="/conf"
readonly data_dir="/data"

getent group inside >/dev/null || \
    addgroup -g ${PGID:-1000} inside 2>/dev/null
getent passwd inside >/dev/null || \
    adduser -D -H -h /var/empty -s /sbin/nologin -G inside -u ${PUID:-1000} inside 2>/dev/null

set -eu

test -f ${conf_dir}/redis.conf || { echo "Configuration file not found."; exit 1; }

chown -R inside:inside ${conf_dir} ${data_dir}

exec su-exec inside:inside "$@"
