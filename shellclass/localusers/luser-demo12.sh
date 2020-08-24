#!/bin/bash

# Script deletes a user.

# Requires root.

if [[ "${UID}" -ne 0 ]]
then
  echo 'Please run with sudo or as root.' >&2
  exit 1
fi

# first arg is user to deletes
USER="${1}"

# delete user
userdel ${USER}

# check to see if user was successfully deleted
if [[ "${?}" -ne 0 ]]
then
  echo "The account ${USER} was NOT deleted." >&2
  exit 1
fi

echo "User ${USER} was deleted"

exit 0
