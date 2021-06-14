#!/usr/bin/env sh

readonly conf_dir="/etc/lighttpd"
readonly data_dir="/data"

getent group lighttpd >/dev/null || \
    addgroup -g ${PGID:-1000} lighttpd 2>/dev/null
getent passwd lighttpd >/dev/null || \
    adduser -D -H -h ${data_dir} -s /sbin/nologin -G lighttpd -g git -u ${PUID:-1000} lighttpd 2>/dev/null

set -eu

chown -R lighttpd:lighttpd /var/log/lighttpd

# Check the configuration file before running
/usr/sbin/lighttpd -f ${conf_dir}/lighttpd.conf -t >/dev/null

exec "$@"
