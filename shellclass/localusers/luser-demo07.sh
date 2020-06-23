#!/bin/bash

# Demo use of shift cmd and while loops

# Display first 3 paramaters
echo "Parameter 1: ${1}"
echo "Parameter 2: ${2}"
echo "Parameter 3: ${3}"
echo

# Loop through all positional paramters
while [[ "${#}" -gt 0 ]]
do
  echo "Number of paramters: ${#}"
  echo "Parameter 1: ${1}"
  echo "Parameter 2: ${2}"
  echo "Parameter 3: ${3}"
  echo
  shift
done

