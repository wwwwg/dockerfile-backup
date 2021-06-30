#!/usr/bin/env sh

readonly conf_dir="/conf"

cat >/usr/local/bin/checkconf <<-EOF
	#!/usr/bin/env sh
	echo "Check the configuration file for errors."
	/usr/sbin/nginx -c ${conf_dir}/nginx.conf -t
EOF

cat >/usr/local/bin/reload <<-EOF
	#!/usr/bin/env sh
	echo "Reload configuration files."
	/usr/sbin/nginx -s reload
EOF

chmod +x /usr/local/bin/checkconf /usr/local/bin/reload

set -eu

test -f ${conf_dir}/nginx.conf || { echo "Configuration file not found."; exit 1; }

exec "$@"
