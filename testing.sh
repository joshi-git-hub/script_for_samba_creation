#!/bin/bash
ssh root@192.168.2.117 '{
echo "give any keyword name either red or blue:-"
read a
if [[ $a = "red" || $a = "blue" ]]
then
 echo "ok thanks."
 echo "$a" > /test_of_read.txt
echo "put directory name."
read d
mkdir /$d
echo "For practice i am going to make files inside of $dir. please give any starting name of files."
read f
touch /$d/$f
ls /$d
else 
 echo "Not ok. Something wrong."
fi
systemctl restart sshd
b=echo "$?"
if [ $b = 0 ]
then
echo "************************Congratulation, you have successfully installed Samba server.*******************************"
echo "^^^^^^^^^^^^^^So lets try to accesss Samba server.^^^^^^^^^^^^^^^^^^^^^"
smbclient //$1/$dc
else
echo "There is somting wrong."
fi

}'
