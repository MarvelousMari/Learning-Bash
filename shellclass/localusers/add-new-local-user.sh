#!/bin/bash

# create new user with strong passowrd with a one line command

# check for root privleges
if [[ "${UID}" != "0" ]]
then
  echo "you need root privleges to run this script"
  echo "use -h or --help"
  exit 1
fi

# declare variables
USER_NAME=""
COMMENT=""
# better PASSWORD
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c 48)

# an even better password
SPECCHAR=$(echo "!@#$%^&*()_-+=" | fold -w1 | shuf | head -c1)
PASSWORD="${PASSWORD}${SPECCHAR}"

# check to make sure there are PARAMETERs
if [[ "${#}" == "0" ]]
then
  echo "USER_NAME [COMMENT]..."
  echo "-h or --help for this page"
  exit 1
# get USER_NAME and COMMENT and check for help
elif [[ "${1}" == "-h" || "${1}" == "--help" ]]
then
  echo "USER_NAME [COMMENT]..."
  echo "-h or --help for this page"
  exit o
else
  USER_NAME=${1}
  shift
# add remaining PARAMETERs to COMMENT
  for PARAMETER in ${@}
  do
    COMMENT="${COMMENT}${PARAMETER}"
  done
fi

# useradd
useradd -c "${COMMENT}" -m ${USER_NAME} | 2> echo "User not created" && exit 1

# Add password
echo "${PASSWORD}" | passwd --stdin ${USER_NAME}

# Expire password, so the end user has to change it on first login
passwd -e ${USER_NAME}

# Echo the user details
echo "The Username is: "
echo ${USER_NAME}
echo "The Password is: "
echo ${PASSWORD}
echo "Hostname: "
echo $(hostname)
exit 0
