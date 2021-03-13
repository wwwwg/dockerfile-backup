#!/usr/bin/env sh

readonly conf_dir="/conf"
readonly data_dir="/data"

cat >/usr/local/bin/checkconf <<-EOF
	#!/usr/bin/env sh
	echo "Checks configuration file for errors."
	/usr/sbin/AdGuardHome -c ${conf_dir}/AdGuardHome.yaml -w ${data_dir} --check-config
EOF

chmod +x /usr/local/bin/checkconf

set -eu

test -f ${conf_dir}/AdGuardHome.yaml || set -- "$@" "-h" "0.0.0.0"

chown -R nobody:nobody ${conf_dir} ${data_dir}

exec su-exec nobody:nobody "$@"
