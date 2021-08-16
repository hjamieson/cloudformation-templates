
sudo yum install krb5-server
sudo yum install -y krb5-workstation

sudo vi /etc/krb5.conf
sudo vi /var/kerberos/krb5kdc/kdc.conf

[ec2-user@ip-10-84-8-116 ~]$ sudo kdb5_util create -s
Loading random data
Initializing database '/var/kerberos/krb5kdc/principal' for realm 'WEDGIE.ORG',
master key name 'K/M@WEDGIE.ORG'
You will be prompted for the database Master Password.
It is important that you NOT FORGET this password.
Enter KDC database master key: wedgie

edit acl filr grant permissions to principals:
sudo vi /var/kerberos/krb5kdc/kadm5.acl

kadmin.local
ktadd -k kadm5.keytab kadmin/admin kadmin/changepw

