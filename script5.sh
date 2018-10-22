#!/bin/bash
ssh root@192.168.2.117 '{
yum install samba* -y
systemctl start smb
systemctl enable smb
firewall-cmd --permanent --add-service=samba
firewall-cmd --reload
read -e "Please give the directory name, which has to be shared:- " dir
mkdir /$dir
touch /$dir/qwer{1..9}
chcon -R -t samba_share_t /$dir
systemctl restart smb
read -e "Please give the Samba shared point name:-" dc
cat << eof  >> /etc/samba/smb.conf
[$dc]
comment=this is samba server installation for all
path=/$dir
public=yes
writable=no
browseable=yes
printable=no
eof
systemctl restart smb
}'
