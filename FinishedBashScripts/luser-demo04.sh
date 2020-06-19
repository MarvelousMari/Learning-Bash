#!/bin/bash

# This script creates an account locally
# Promts for account name and password

# Ask for the user name
read -p "Enter the username to create: " USER_NAME

# Ask for real name.
read -p "Enter the name of the person this account is for: " COMMENT

# Aask for the password.
read -p "Enter the password to use for the account: " PASSWORD

# Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login.
passwd -e ${USER_NAME}
