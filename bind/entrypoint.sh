#!/usr/bin/env sh

readonly conf_dir="/etc/bind"

cat >/usr/local/bin/checkconf <<-EOF
	#!/usr/bin/env sh
	echo "Checks configuration file for errors."
	/usr/sbin/named-checkconf -p ${conf_dir}/named.conf
EOF

cat >/usr/local/bin/checkzone <<-EOF
	#!/usr/bin/env sh
	echo "Checks zone file for errors."
	/usr/sbin/named-checkzone ${1} "${conf_dir}/data/${1}.zone"
EOF

cat >/usr/local/bin/reload <<-EOF
	#!/usr/bin/env sh
	echo "Reload configuration file and zones."
	/usr/sbin/rndc -c ${conf_dir}/rndc.conf reload
EOF

chmod +x /usr/local/bin/checkconf /usr/local/bin/checkzone /usr/local/bin/reload

set -eu

test -f ${conf_dir}/named.conf || { echo "Configuration file not found."; exit; }
test -d ${conf_dir}/data       || mkdir ${conf_dir}/data
test -d ${conf_dir}/dynamic    || mkdir ${conf_dir}/dynamic

# Generate key required for reload to work

if [ ! -f "${conf_dir}/rndc.key" ]; then
    echo "rndc: The key file is missing, try to generate a new one."
    /usr/sbin/rndc-confgen -a -c ${conf_dir}/rndc.key
fi

chown -R nobody:nobody ${conf_dir}/data ${conf_dir}/dynamic /run/named

exec "$@"
