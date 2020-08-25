#!/bin/bash
for (( i = 0; i <= "10"; i++ ))
do
  userdel -rf "testUser${i}"
done
exit 0
