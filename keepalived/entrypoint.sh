#!/usr/bin/env sh

readonly conf_dir="/etc/keepalived"

cat >/usr/local/bin/checkconf <<-EOF
	#!/usr/bin/env sh
	echo "Check the configuration file for errors."
	/usr/sbin/keepalived -t
EOF

cat >/usr/local/bin/reload <<-'EOF'
	#!/usr/bin/env sh
	echo "Reload configuration files."
	kill -s HUP `cat /var/run/keepalived/keepalived.pid`
EOF

chmod +x /usr/local/bin/checkconf /usr/local/bin/reload

set -eu

test -f ${conf_dir}/keepalived.conf || { echo "Configuration file not found."; exit 1; }

exec "$@"
