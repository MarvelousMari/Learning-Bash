#!/bin/bash

# This script creates a random password

# A random number as a password
PASSWORD=${RANDOM}
echo "${PASSWORD}"

# Three random numbers together for the PASSWORD
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"


# use current date/time for PASSWORD
PASSWORD=$(date +%s)
echo "${PASSWORD}"


# time with nanoseconds
PASSWORD=$(date +%s%N)
echo "${PASSWORD}"

# Using checkSUm to generate a hex based cryptohash and create password
PASSWORD=$(date +%s | sha256sum | head -c 32)
echo "${PASSWORD}"

# better PASSWORD
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c 48)
echo "${PASSWORD}"

# an even better password
SPECCHAR=$(echo "!@#$%^&*()_-+=" | fold -w1 | shuf | head -c1)
PASSWORD="${PASSWORD}${SPECCHAR}"
echo "${PASSWORD}"
