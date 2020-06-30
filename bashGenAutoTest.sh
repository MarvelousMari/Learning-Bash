#!/bin/bash

echo
echo "test1: F"
./bashGenV2.sh test1
if [[ "${?}" == "1" ]]
then
  echo "Failed test1"
  echo "./bashGenV2.sh test1"
else
  echo "TRUE"
fi

echo

echo
echo "test2: F"
./bashGenV2.sh test2 -
if [[ "${?}" == "1" ]]
then
  echo "Failed test2"
  echo "./bashGenV2.sh test2 -"
else
  echo "TRUE"
fi

echo

echo
echo "test3: T"
./bashGenV2.sh test3 -a
if [[ "${?}" == "1" ]]
then
  echo "Failed test3"
  echo "./bashGenV2.sh test3 -a"
else
  echo "TRUE"
fi

echo

echo
echo "test4: T"
./bashGenV2.sh test4 -v
if [[ "${?}" == "1" ]]
then
  echo "Failed test4"
  echo "./bashGenV2.sh test4 -v"
else
  echo "TRUE"
fi

echo

echo
echo "test5: F"
./bashGenV2.sh test5 - -
if [[ "${?}" == "1" ]]
then
  echo "Failed test5"
  echo "./bashGenV2.sh test5 - -"
else
  echo "TRUE"
fi

echo

echo
echo "test6: T/F"
touch test6.sh
echo "test6">>test6.sh
./bashGenV2.sh test6 -v
if [[ "${?}" == "1" ]]
then
  echo "failed test6"
  echo "touch test6.sh \
    echo \"test6\">>test6.sh\
        ./bashGenV2.sh test6 -v"
else
  echo "TRUE"
fi

echo

echo
echo "test7: T/F"
touch test7.sh
echo "test7">>test7.sh
./bashGenV2.sh test7 -a
if [[ "${?}" == "1" ]]
then
  echo "failed test7"
  echo "touch test7.sh \
    echo \"test6\">>test6.sh\
        ./bashGenV2.sh test7 -a"
else
  echo "TRUE"
fi

echo

echo
echo "test8: T"
./bashGenV2.sh -h
if [[ "${?}" == "1" ]]
then
  echo "failed test8"
  echo "./bashGenV2.sh -h"
else
  echo "TRUE"
fi

echo

echo
echo "test9: T"
./bashGenV2.sh --help
if [[ "${?}" == "1" ]]
then
  echo "failed test9"
  echo "./bashGenV2.sh --help"
else
  echo "TRUE"
fi

echo

echo
echo "test10: F"
./bashGenV2.sh
if [[ "${?}" == "1" ]]
then
  echo "failed test10"
  echo "./bashGenV2.sh"
else
  echo "TRUE"
fi

echo

for (( i = 1; i<11; i++ ));
do
  rm "test${i}.sh"
  if [[ "${?}" == "1" ]]
  then
    echo "couldn't delete test${i}.sh"
  fi
done
exit 0
