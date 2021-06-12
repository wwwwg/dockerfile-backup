#!/usr/bin/env sh

readonly conf_dir="/conf"

set -eu

test -f ${conf_dir}/rsyncd.conf || { echo "Configuration file not found."; exit 1; }

exec "$@"
