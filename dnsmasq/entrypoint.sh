#!/usr/bin/env sh

readonly conf_dir="/conf"

cat >/usr/local/bin/checkconf <<-EOF
	#!/bin/sh
	echo "Read and syntax check configuration files."
	/usr/sbin/dnsmasq --conf-file=${conf_dir}/dnsmasq.conf --test
EOF

cat >/usr/local/bin/reload <<-'EOF'
	#!/usr/bin/env sh
	echo "Reload configuration files."
	kill -s HUP `cat /var/run/dnsmasq.pid`
EOF

chmod +x /usr/local/bin/checkconf /usr/local/bin/reload

set -eu

test -f ${conf_dir}/dnsmasq.conf || { echo "Configuration file not found."; exit 1; }

exec "$@"
