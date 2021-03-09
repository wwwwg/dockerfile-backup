#!/usr/bin/env sh

readonly conf_dir="/conf"
readonly data_dir="/data"

getent group inside >/dev/null || \
    addgroup -g ${PGID:-1000} inside 2>/dev/null
getent passwd inside >/dev/null || \
    adduser -D -H -h ${conf_dir} -s /sbin/nologin -G inside -u ${PUID:-1000} inside 2>/dev/null

set -eu

test -f ${conf_dir}/aria2.conf    || { echo "Configuration file not found."; exit 1; }
test -f ${conf_dir}/aria2.session || touch ${conf_dir}/aria2.session

chown -R inside:inside ${conf_dir} ${data_dir}
chmod 600 ${conf_dir}/aria2.conf

exec su-exec inside:inside "$@"
