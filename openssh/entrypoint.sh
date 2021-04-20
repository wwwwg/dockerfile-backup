#!/usr/bin/env sh

readonly conf_dir="/etc/ssh"

cat >/usr/local/bin/checkconf <<-EOF
	#!/usr/bin/env sh
	echo "Checks configuration file for errors."
	/usr/sbin/sshd -t
EOF

cat >/usr/local/bin/reload <<-'EOF'
	#!/usr/bin/env sh
	echo "Reload configuration files."
	kill -HUP `cat /var/run/sshd.pid`
EOF

chmod +x /usr/local/bin/checkconf /usr/local/bin/reload

set -eu

# Generate hostkeys if not exists
ssh-keygen -A >/dev/null

# Enable root account
if [ -r "${conf_dir}/users.txt" ]; then
    chpasswd < ${conf_dir}/users.txt
else
    passwd -u root 2>/dev/null
fi

# Check the configuration file before running
/usr/sbin/sshd -t

exec "$@"
