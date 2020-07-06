#!/bin/bash

# this script demos I/O redirection

# redirect STDOUT to a file
FILE="/tmp/data"
# > redirects STDOUT
head -n1 /etc/passwd > ${FILE}

# redirect STDIN to a program
# reads first line in FILE and assign it to var LINE
read LINE < ${FILE}
# echo LINE var
echo "LINE contains: ${LINE}"

# USE < and > to handle STDIN and STDOUT from files
# USE Pipes for command to command
# > creates a file if none exists, if the file EXISTS it is OVERRIDDEN

# redirect STDOUT to a file, OVERRIDDing the files
head -n3 /etc/passwd > ${FILE}
echo
echo "Contents of ${FILE}: "
cat ${FILE}

# USE >> to append to file

# redirect STDOUT to a file, appending to the file
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo
echo "Contents of ${FILE}: "
cat ${FILE}
