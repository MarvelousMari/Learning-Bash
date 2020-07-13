#!/bin/bash

# script temos the 'case' statement.

# if [[ "${1}" = 'start' ]]
# then
#   echo 'starting'
# elif [[ "${1}" = 'stop' ]]
# then
#   echo 'stopping'
# elif [[ "${1}" = 'status' ]]
# then
#   echo 'status:'
# else
#   echo 'supply a valid option' >&2
#   exit 1
# fi

# case "${1}" in
#   start)
#     echo 'starting'
#     ;;
#   stop)
#     echo 'stopping'
#     ;;
#   status|state|--status|--state)
#     echo 'status: '
#     ;;
#   *)
#     echo 'need a valid option' >&2
#     exit 1
#     ;;
# esac

case "${1}" in
  start) echo 'starting' ;;
  stop) echo 'stopping' ;;
  status) echo 'status: ' ;;
  *)
    echo 'need a valid option' >&2
    exit 1
    ;;
esac
