#!/bin/bash
REALM=${1:-WEDGIE.COM}

cat <<HEREFILE > /var/kerberos/krb5kdc/kadm5.acl
*/admin@${REALM}     *

HEREFILE
