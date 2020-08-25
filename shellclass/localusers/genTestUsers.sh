#!/bin/bash
# generate users with home directory
# NOT WORKING NEEDS TESTING
for (( i = 0; i <= "${1}"; i++ ))
do
  # -m create home -M no home
  useradd -m "testUser${i}"
  if [[ "${?}" != 0 ]]
  then
    echo "Didn't create user:   testUser${i}"
  fi
  echo "pass123" | passwd --stdin "testUser${i}" > /dev/null
  if [[ "${?}" != 0 ]]
  then
    echo "Didn't add password to user:   testUser${i}"
  fi
  echo "testUser${i}" >> "/home/testUser${i}/testText${i}.txt"
  if [[ "${?}" != 0 ]]
  then
    echo "Didn't create file for:   testUser${i}"
  fi
done
if [[ "${?}" != 0 ]]
then
  echo "Didn't work"
  exit 1
fi
exit 0
