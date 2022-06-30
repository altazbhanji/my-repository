#!/bin/bash -x
#
# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.
MYUSERID=$(id -u)
if [[ MYUSERID -ne 0 ]]
then
	echo "Please run this as sudo"
	exit 1
fi

# Get the username (login).
read -p "Enter the username to create: " USER_NAME


# Get the contents for the description field
read -p "Enter the role for the user: " COMMENT


# Get the password.
read -sp "Enter the password for the user: " PASSWORD
echo

#
# chars = [abcdefgh......!@#$]
# for x from 1 to 10
#	get random char from chars
#	add to passwd
# 

# Create the account.
useradd -c "${COMMENT}" -m ${USER_NAME} 2> /dev/null


# Check to see if the useradd command succeeded.
# We don't want to tell the user that an account was created when it hasn't been.
if [[ "$?" -ne 0 ]]
then
	echo "Error creating user"
	exit 2
fi


# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded.
if [[ "$?" -ne 0 ]]
then
        echo "Error creating password"
        exit 3
fi


# Force password change on first login.
passwd -e ${USER_NAME}


# Display the username and password where the user was created.
echo
echo 'new username: ' ${USER_NAME}
echo 'password:     ' ${PASSWORD}
echo 'Please note user will be required to change password at login'
echo
echo 'Done.'



