#!/bin/bash
#linux/UNIX
######################################
# Developed by Carlos Eduardo Hodnik #
# Backup Fortinet Using SCP          #
# Mail: eduardohodnik@gmail.com      #
######################################

# I DECLARE FORTINET FOR BACKUP
SERVERS1="IP_OR_HOSTNAME_FORTINET"

#FTP DATA TO SEND BACKUP.
FTPSERVER="IP_FTP"
USERNAME="USERNAME_FOR_FTP"
PASSWORD="PASSWORD"
LOCALDIR="/bkp_fortinet/"

# SSH User name
# CREATE A USER READING ONLY IN FORTINET
USR="backup"
PWD="PASSWORD"
timestamp=$(date +"%m-%d-%y %H-%M")
LOG=""

# I DECLARE NAME OF THE UNITS FORTINET
FTG1="NAME"


#Backup SERVERS1
# connect each host
for host in $SERVERS1
do
sshpass -p $PWD scp -P 12022 -o StrictHostKeyChecking=no $USR@$host:sys_config /home/fortinetbkp/bkp_fortinet/"$timestamp"_"$FTG1".conf 
done

# Sending Mail after backup
if [[ -s /home/fortinetbkp/bkp_fortinet/"$timestamp"_"$FTG1".conf ]]; then
echo Backup Fortinet "$FTG1">> backup.log
echo Backup Fortigate available in $FTPSERVER >>backup.log
echo Backup successfully held in /home/fortinetbkp/bkp_fortinet/"$timestamp"_"$FTG1".conf >> backup.log
cat backup.log | mail -s "Backup Fortinet" mail@domain.com
else
echo Backup Fortinet "$FTG1">> backup.log
echo Backup performed with failure !!! VERIFIQUEM POR FAVOR >> backup.log
cat backup.log | mail -s "Backup Fortinet" mail@domain.com
fi;
rm -rf backup.log
# End of backup SERVERS1


# Connecting to the FTP server and sending files

echo "Connecting to FTP server ..."
ftp -vin $FTPSERVER << FTP
user $USERNAME $PASSWORD

echo "Connected and within the root directory."
lcd /home/fortinetbkp/bkp_fortinet/
cd $LOCALDIR

#Sending Backup
echo Sending File...
mput /home/fortinetbkp/bkp_fortinet/*.* $LOCALDIR

bye
EOF
FTP

# End of Transfer

