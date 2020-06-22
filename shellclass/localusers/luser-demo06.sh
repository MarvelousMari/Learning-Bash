#!/bin/bash

# This script generates a random password for each user specified on the command line

# display what the user typed on the command line
echo "You executed this command: ${0}"

# Display path and filename of script
echo "You used $(dirname ${0}) as the path to the $(basename ${0}) script."

# tell the user number of arguments they passed in
# inside the script they are paramerters outside they are arguments
NUMBER_OF_PARAMETERS="${#}"
echo "you supplied ${NUMBER_OF_PARAMETERS} argument(s) to the command line."

# check to make sure at least one argument was supplied
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [USER_NAME]..."
  exit 1
fi


#R Generate and display a passwordd for each parameter.
for USER_NAME in "${@}"
do
  PASSWORD=$(date +%s%N| sha256sum| head -c48)
  echo "${USER_NAME} : ${PASSWORD}"
done

