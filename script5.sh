#!/bin/bash
ssh root@$1 '{
yum install samba* -y
systemctl start smb
systemctl enable smb
firewall-cmd --permanent --add-service=samba
firewall-cmd --reload
echo "Please give the directory name, which has to be shared:- " 
read dir
mkdir /$dir
echo "Please give any two file name for creating inside of /$dir."
read f1 f2
touch /$dir/$f1
touch /$dir/$f2
chcon -R -t samba_share_t /$dir
systemctl restart smb
echo "Please give the Samba shared point name:-"
read dc
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
b=`echo $?`
if [ $b = 0 ]
then
echo -e "\033[01;32;44m************************Congratulation, you have successfully installed Samba server.*******************************\033[0m"
echo -e "\n\n"
sleep 3
echo -e "\033[01;32;44m^^^^^^^^^^^^^^So lets try to accesss Samba server.^^^^^^^^^^^^^^^^^^^^^\033[0m"
echo -e "\n\n"
sleep 2
else
echo "There is somting wrong."
fi
}'


