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

# Redirect STDIN to a program using FD 0
read LINE 0< ${FILE}
echo
echo "LINE contains: ${FILE}"

# Redirect STDOUT to a program using FD1, overwritting file
head -n3 /etc/passwd 1> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# Redirect STDERR to a file using FD2
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}

# Redirect STDOUT and STDERR to a file
head -n3 /etc/passwd /fakefile &> ${FILE}
echo
echo "contents of ${FILE} :"
cat ${FILE}

# Redirect STDOUT and STDERR through a Pipe
echo
head -n3 /etc/passwd /fakefile |& cat -n

# Send output to STDERR
echo "this is STDERR!" >&2

# /dev/null aka bitbuker to send output to delete
# often used to hide whats happening from the user

# Discard STDOUT
echo
echo "Discarding STDOUT: "
head -n3 /etc/passwd /fakefile > /dev/null

# discard STDERR
echo
echo "Discarding STDERR: "
head -n3 /etc/passwd /fakefile 2> /dev/null

# Discard STDOUT and STDERR
echo
echo "Discarding STDOUT and STDERR: "
head -n3 /etc/passwd /fakefile &> /dev/null


# Clean up files ignore output
rm ${FILE} ${ERR_FILE} &> /dev/null
