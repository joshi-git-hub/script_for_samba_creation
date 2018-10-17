#!/bin/bash
ssh root@192.168.2.117 '{
yum install samba* -y
systemctl start smb
systemctl enable smb
firewall-cmd --permanent --add-service=samba
firewall-cmd --reload
mkdir /nokia
touch /nokia/qwer{1..9}
chcon -R -t samba_share_t /nokia
systemctl restart smb
cat << eof  >> /etc/samba/smb.conf
[gdc]
comment=this is samba server installation for all
path=/nokia
public=yes
writable=no
browseable=yes
printable=no
eof
systemctl restart smb
}'
