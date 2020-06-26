#!/bin/bash

# this script generates a new file adds a shebang then opens it in either atom or vim
# also catches improper uses
FILENAME=""
EDITOR=""

#check to see if there are too many arguments provided
if [[ ${#} -gt 2 ]]
then
  echo "${@} is too many arguments"
  echo "use -h or --help to see proper format"
fi

# check for help
if [[ ${1} == "-h" || ${1} == "--help" ]]
then
  echo "FILENAME EDITOR"
  echo "FILENAME doesn't need .sh extension"
  echo "EDITOR options: "
  echo "	-a or --atom opens file in Atom text editor"
  echo "	-v or --vim opens file in Vim text editor"
  exit 0
else
  FILENAME="${1}.sh"
  shift
fi

#check if file exists and is not empty
if [[ -s ${PWD}/${FILENAME} ]]
then
  echo "File already exists"
  # loops till a valid Y/N response is given
  VALIDYN=false
  while [[ "${VALIDYN}" == false ]]
  do
  read -p "do you wish to open the file?[Y/N] " ANSWER
    if [[ "${ANSWER}" == "Y" || "${ANSWER}" == "y" ]]
    then
      VALIDYN=true
    elif [[ "${ANSWER}" == "N" || "${ANSWER}" == "n" ]]
    then
      VALIDYN=true
      echo "You've choosen not to open the file"
      exit 0
    fi
  done
else
  #create file, add shabang, and make the file executeable
  touch "${FILENAME}"
  echo "#!/bin/bash">>${FILENAME}
  chmod 755 ${FILENAME}
fi

# find the editor to use
if [[ ${1} == "-a" || ${1} == "--atom" ]]
then
  atom ${FILENAME}
  # check to make sure this executed correctly
  if [[ ${?} == "1" ]]
  then
    echo "error when attempting to open ${FILENAME} with: ${EDITOR} as the editor argument"
    exit 1
  else
    exit 0
  fi
elif [[ ${1} == "-v" || ${1} == "--vim" ]]
then
  vim ${FILENAME}
  # check to make sure this executed correctly
  if [[ ${?} == "1" ]]
  then
    echo "error when attempting to open ${FILENAME} with: ${EDITOR} as the editor argument"
    exit 1
  else
    exit 0
  fi
else
  echo "${1} is not a vaild editor option"
  echo "use -h or --help to get proper format"
  exit 1
fi
