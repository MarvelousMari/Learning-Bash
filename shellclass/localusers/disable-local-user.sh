#!/bin/bash

# usage statement/ man page
usage () {
  echo "USAGE: [-dra] USER [USERN]"
  echo "Disable a local Linux user"
  echo "  -d  Deletes account rather than disabling"
  echo "  -r  Removes home directory for the account(s)"
  echo "  -a  Archive home directory for the account(s)"
}

# check for root privliges
if [[ "${UID}" -ne 0 ]]
then
  echo "root privliges required!"
  usage
  exit 1
fi

# Accepts a list of Usernames as Arguments, must have at least 1 username else
# show usage statement and exit 1, all sent via stdErr
if [[ "${#}" < 1 ]]
then
  echo "need at least 1 USER argument"
  usage
  exit 1
fi

# disables by default
# set defaults
DEL_ACCT='false'
DEL_HOME='false'
ARCHIVE='false'


# options are
# -d  Deletes acounts instead of disabling
# -r  Removes home directory for accounts
# -a  Creates an archive of the home directory associated with the account(s)
#     stores the archive in /archives (will need to be created if it doesn't exist)
# *   Any non specified option cause the script to show usage statement an exit 1

while getopts dra OPTION
do
  case ${OPTION} in
    d)
      DEL_ACCT='true'
      echo "DEL_ACCT: ${DEL_ACCT}"
      ;;
    r)
      DEL_HOME='true'
      echo "DEL_HOME: ${DEL_HOME}"
      ;;
    a)
      ARCHIVE='true'
      echo "ARCHIVE: ${ARCHIVE}"
      ;;
    ?)
      usage
      exit 1
  esac
done
shift $((OPTIND -1))

for USR_IN_PROGRESS in ${@}
do
  # if the user exists and has a UID over 1000
  id -u ${USR_IN_PROGRESS}
  if [[ "${?}" != "0" ]]
  then
    echo "${USR_IN_PROGRESS} is not a valid username"
    usage
    exit 1
  fi

  if [[ $(id -u ${USR_IN_PROGRESS}) -lt 1000 ]]
  then
    echo "${USR_IN_PROGRESS} has a UID under 1000 will not disable"
    usage
    exit 1
  fi

  if [[ "${ARCHIVE}" == "true" ]]
  then
    if [[ (! -d "${PWD}/archive") ]]
    then
      mkdir "archive"
    fi
    tar -zcf  "${PWD}/archive/${USR_IN_PROGRESS}.tar.gz" "/home/${USR_IN_PROGRESS}"
    if [[ "${?}" -ne 0 ]]
    then
      echo "Failed to archive the home folder of: ${USR_IN_PROGRESS}"
      exit 1
    fi
  fi

  if [[ "${DEL_HOME}" == "true" ]]
  then
    rm -dfr "/home/${USR_IN_PROGRESS}"
    if [[ "${?}" -ne 0 ]]
    then
      echo "Failed to delete home folder of: ${USR_IN_PROGRESS}"
      exit 1
    fi
  fi

  if [[ "${DEL_ACCT}" == "true" ]]
  then
    # Delete
    userdel ${USR_IN_PROGRESS}
    if [[ "${?}" -ne 0 ]]
    then
      echo "Failed to delete user: ${USR_IN_PROGRESS}"
      exit 1
    fi
  else
    # disables
    chage -E 0 ${USR_IN_PROGRESS}
    if [[ "${?}" -ne 0 ]]
    then
      echo "Failed to disable user: ${USR_IN_PROGRESS}"
      exit 1
    fi
  fi

done

exit 0

# Informs user of any errors
# Displays username and any action performed on the account
