#!/bin/bash
# updates the krb5.conf with the current host as the KDC.
# you can override this by passing in a value for $1

LOCAL_IPV4=$(curl -s 169.254.169.254/latest/meta-data/local-ipv4)
KDC_HOST=${1:-$LOCAL_IPV4}

cat <<HEREFILE > /tmp/krb5.conf

# Configuration snippets may be placed in this directory as well
includedir /etc/krb5.conf.d/

[logging]
 default = FILE:/var/log/krb5libs.log
 kdc = FILE:/var/log/krb5kdc.log
 admin_server = FILE:/var/log/kadmind.log

[libdefaults]
 dns_lookup_realm = false
 ticket_lifetime = 24h
 renew_lifetime = 7d
 forwardable = true
 rdns = false
 pkinit_anchors = /etc/pki/tls/certs/ca-bundle.crt
 default_realm = WEDGIE.COM
 default_ccache_name = KEYRING:persistent:%{uid}

[realms]
 WEDGIE.COM = {
  kdc = $KDC_HOST
  admin_server = $KDC_HOST
 }

[domain_realm]
 .wedgie.com = WEDGIE.COM
 wedgie.com = WEDGIE.COM

HEREFILE
mv -b /tmp/krb5.conf /etc/krb5.conf
echo "krb5.conf updated rc=$?"