#!/bin/bash
# removes the a records for this host under dev.oclc.org!

var_fqdn=$(hostname -f)
var_oct2host=`echo $var_fqdn | awk -F "." '{print $2}'`
var_domain=$var_oct2host.oclc.org
var_localip=$(curl --silent http://169.254.169.254/latest/meta-data/local-ipv4/)
var_oct1=`echo $var_localip | awk -F "." '{print $1}'`
var_oct2=`echo $var_localip | awk -F "." '{print $2}'`
var_reverse_zone=$var_oct2.$var_oct1.in-addr.arpa
var_reverse_ip=$(curl --silent http://169.254.169.254/latest/meta-data/local-ipv4/ | awk -F"." '{for(i=NF;i>0;i--) printf i!=1?$i".":"%s",$i}')

echo $var_fqdn
echo $var_reverse_ip

# Register to DNS
cat<<EOF > /tmp/dns-reg
server 10.32.47.51
zone $var_domain
update delete $var_fqdn A
send
zone $var_reverse_zone
update delete $var_reverse_ip.in-addr.arpa PTR
send
EOF

/usr/bin/nsupdate -v /tmp/dns-reg
echo "DNS de-registration completed rc=$?"