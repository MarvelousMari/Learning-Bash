#!/bin/bash

# this script generates a random passwd
# user can set passwd length with -l and add a special characther with -#!/bin/sh
# can get extra info they can use Verbose -v

usage() {
  echo "USAGE: ${0} [-vs] [-l LENGTH]" >&2
  echo 'Generate a random password'
  echo '  -l LENGTH password length'
  echo '  -s        append a special character to the password'
  echo '  -v        Verbose mode'
  exit 1
}

verbLog() {
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

# defailt passwd length
LENGTH=48

while getopts vl:s OPTION
do
  case ${OPTION} in
    v)
      VERBOSE='true'
      verbLog 'Verbose mode on.'
      ;;
    l)
      LENGTH="${OPTARG}"
      ;;
    s)
      USE_SPECIAL_CHARACTER='true'
      ;;
    ?)
      usage
      ;;
  esac
done

# echo "Number of args: ${#}"
# echo "All args: ${@}"
# echo "first arg: ${1}"
# echo "second arg: ${2}"
# echo "thrid arg: ${3}"


echo "OPTIND: ${OPTIND}"
shift "$(( OPTIND - 1 ))"

# echo 'After shift'
# echo "Number of args: ${#}"
# echo "All args: ${@}"
# echo "first arg: ${1}"
# echo "second arg: ${2}"
# echo "thrid arg: ${3}"

if [[ "${#}" -gt 0 ]]
then
  usage
fi



verbLog 'Generating Password'

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

# append special character
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
  verbLog 'Selecting a random special character'
  SPECIAL_CHARACTER=$(echo '!@#$%^&*()-+=' | fold -w1 | shuf | head -c1)
  PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

verbLog 'Done'
verbLog 'Here is the password:'

echo "${PASSWORD}"

exit 0
