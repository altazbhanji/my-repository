#!/bin/bash

# Check if we are root privilage or not
MYUSERID=$(id -u)
if [[ MYUSERID -ne 0 ]]
then
        echo "Please run this as sudo"
        exit 1
fi


# Which files are we going to back up. Please make sure to exist /home/ec2-user/data file
BACKUP_FILES='/home/ec2-user/data /etc /boot /usr'


# Where do we backup to. Please crete this file before execute this script
DESTINATION='/mnt/backup'


# Create archive filename based on time
MYTIME=$(date +"%Y_%m_%d_%H_%M_%S")
MYHOST=$(hostname)
FILENAME="${MYHOST}_${MYTIME}.tgz"

DESTINATION_FILENAME=${DESTINATION}/${FILENAME}

# Print start status message.
echo "Getting ready to backup ${BACKUP_FILES} to ${DESTINATION_FILENAME}"


# Backup the files using tar.
sudo tar -czf ${DESTINATION_FILENAME} ${BACKUP_FILES}

# Print end status message.
echo
echo "Successfully completed backup!"
echo


# Long listing of files in $dest to check file sizes.
ls -lh ${DESTINATION}

