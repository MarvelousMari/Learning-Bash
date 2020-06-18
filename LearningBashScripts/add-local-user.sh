#!/bin/bash

# Check for root
if [[ "${UID}" != 0 ]]
then
  echo "You need root privleges to use this script"
  exit 1
fi

# Collect username, name, and password
read -p "Type the user to create's username: " USER_NAME

read -p "Input the user's real name and any comments on the user: " COMMENT

read -p "Enter the user's password: " PASSWORD

# add the user, also exit with 1 if it can't, a diffrent way will be shown later
useradd -c "${COMMENT}" -m ${USER_NAME} | 2> echo "exiting with 1" && exit 1

# Add password
echo "${PASSWORD}" | passwd --stdin ${USER_NAME}
if [[ "${?}" != 0 ]]
then
  echo "Password couldn't be set"
  exit 1
fi

# Echo the user details
echo "The Username is: "
echo ${USER_NAME}
echo "The Password is: "
echo ${PASSWORD}
echo "Hostname: "
echo $(hostname)

# Expire password, so the end user has to change it on first login
passwd -e ${USER_NAME}
echo "password expired, will be promted to create new one on next login"

exit 0
