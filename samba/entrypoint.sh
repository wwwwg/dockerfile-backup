#!/usr/bin/env sh

readonly conf_dir="/etc/samba"

cat >/usr/local/bin/checkconf <<-EOF
	#!/usr/bin/env sh
	echo "Checks configuration file for errors."
	/usr/bin/testparm -s
EOF

cat >/usr/local/bin/reload <<-'EOF'
	#!/usr/bin/env sh
	echo "Reload configuration files."
	/usr/bin/smbcontrol smbd reload-config
EOF

chmod +x /usr/local/bin/checkconf /usr/local/bin/reload

getent group inside >/dev/null || \
    addgroup -g ${PGID:-1000} inside 2>/dev/null
getent passwd inside >/dev/null || \
    adduser -D -H -h /var/empty -s /sbin/nologin -G inside -u ${PUID:-1000} inside 2>/dev/null

set -eu

test -f ${conf_dir}/smb.conf || { echo "Configuration file not found."; exit 1; }

exec "$@"
