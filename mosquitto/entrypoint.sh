#!/usr/bin/env sh

readonly conf_dir="/etc/mosquitto"
readonly data_dir="/var/lib/mosquitto"

getent group mosquitto >/dev/null || \
    addgroup -g ${PGID:-1000} mosquitto 2>/dev/null
getent passwd mosquitto >/dev/null || \
    adduser -D -H -h /var/empty -s /sbin/nologin -G mosquitto -u ${PUID:-1000} mosquitto 2>/dev/null

set -eu

test -f ${conf_dir}/mosquitto.conf || { echo "Configuration file not found."; exit 1; }
test -d ${data_dir}                || mkdir -p ${data_dir}

chown -R mosquitto:mosquitto ${conf_dir} ${data_dir}

# Generated the password file when the password_file directive is enabled.
# mosquitto_passwd -b ${conf_dir}/pwfile abc123 abc321

exec "$@"
