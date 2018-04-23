echo Coreplus Team. 2018.
				#M7 Plantation Camera PTZ Script.
				#Created By Ahmad Syahir (SiNxHaCk).
				#This Script will need a CSV file which it's to read by line.
		

today=`/bin/date '+%d-%m-%Y_%H-%M-%S'`; #This Will Generate the Date.

while IFS=, read -r line1 line2 line3 #this will do a loop with la CSV which its read by line
do

#This Command for PTZ Camera run a preset PTZ was created
wget "http://admin:admin@$line1/cgi-bin/ptz.cgi?action=start&channel=0&code=GotoPreset&arg1=0&arg2=$line2&arg3=0"

sleep 3s

#This Command for Snapshot and save in the TMP folder on linux
wget "http://admin:admin@$line1/cgi-bin/snapshot.cgi?channel=0" -O /tmp/$line3-$today.jpg

sleep 3s


done < TreePic.csv
 sleep 3s

#This Command will send throught FTP, using bash only
#!/bin/bash

HOST=192.168.1.13  #This is the FTP servers host or IP address.
USER=user             #This is the FTP user that has access to the server.
PASS=123456          #This is the password for the FTP user.

# Call 1. Uses the ftp command with the -inv switches. 
#-i turns off interactive prompting. 
#-n Restrains FTP from attempting the auto-login feature. 
#-v enables verbose and progress. 

ftp -nv $HOST << EOF

# Call 2. Here the login credentials are supplied by calling the variables.

user $USER $PASS

# Call 3. Here you will change to the directory where you want to put or get
#cd /tmp/*.jpg

# Call4.  Here you will tell FTP to put or get the file.
binary
mput /tmp/*.jpg

# End FTP Connection
bye

EOF

#Delete Picture After sending on server.
rm /tmp/*.jpg
rm /home/user31/ptz.cgi*

