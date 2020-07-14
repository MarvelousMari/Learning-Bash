#!/bin/bash

# learn how to create and use functions

# log func sends a message to syslog and STDOUT if VERBOSE is true.
log() {
  # avoid creating global variables in functions
  # keep the names unique
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
  logger -t luser-demo10.sh "${MESSAGE}"
}

# backup_file func creates a backup of a file. returns non zero on error
backup_file() {
  local FILE="${1}"

  # check if file exists
  if [[ -f "${FILE}" ]]
  then
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    log "Backing up ${FILE} to ${BACKUP_FILE}."
    # exit status of backup_file func is exit status of cp cmd
    # -p preserves time stamps
    cp -p ${FILE} ${BACKUP_FILE}
  else
    # the file doesn't exist return on 0
    # return inside function exit for entire script
    return 1
  fi
}



readonly VERBOSE='true'
log 'Hello!'
log 'This is funcy!'


# back up and exit if error
backup_file '/etc/passwd'
if [[ "${?}" = '0' ]]
then
  log 'File back up succeded'
else
  log 'File back up failed ERR'
  exit 1
fi
