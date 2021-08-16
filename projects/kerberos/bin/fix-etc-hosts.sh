#!/bin/bash
# expects to be run as root!
# replaces /etc/hosts
echo "setting up good /etc/hosts file..."

IPV4=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
HOSTNAME=$(curl -s 169.254.169.254/latest/meta-data/local-hostname)

echo "host=$HOSTNAME and ip=$IPV4"
cat <<HEREFILE
127.0.0.1	localhost
$IPV4	$HOSTNAME
HEREFILE


cat <<HEREFILE > newhosts
127.0.0.1	localhost
$IPV4	$HOSTNAME
HEREFILE

mv -v newhosts /etc/hosts