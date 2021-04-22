#!/usr/bin/env sh

readonly conf_dir="/etc/lsyncd"

cat >/usr/local/bin/status <<-EOF
	#!/usr/bin/env sh
	if [ -r /tmp/lsyncd.status ]; then
	  cat /tmp/lsyncd.status
	else
	  echo 'No status yet.'
	fi
EOF

chmod +x /usr/local/bin/status

set -eu

test -f ${conf_dir}/main.lua || { echo "Configuration file not found."; exit 1; }

exec "$@"
