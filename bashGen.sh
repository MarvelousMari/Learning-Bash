#!/bin/bash

# this script will create a bash file with a shabang and open it in either vim or atom
# also has a help page
# also will stop most improper usages

#check if any of the paramters ask for help
for PARAMETER in ${@}
do
  if [[ "${PARAMETER}" == "--help" || "${PARAMETER}" == "-h" ]]
  then
    echo "FILENAME EDITOR"
    echo "FILENAME doesn't need .sh extension"
    echo "EDITOR options: "
    echo "	-a opens file in Atom text editor"
    echo "	-v opens file in Vim text editor"
    exit 0
    echo "got past exit"
  fi
done

# get filename and editor
FILENAME="${1}.sh"
shift
EDITOR=${1}
shift

# let the user know if they used any invalid paramters
if [[ ${#} -gt 0 ]]
then
  for PARAMTER in ${@}
  do
    echo "Argument: ${PARAMETER} is not a valid"
  done
  echo "Use -h or --help for options"
fi

#check if file to create doesn't already contain anything
if [[ -s ${PWD}/${FILENAME} ]]
then
  echo "file already exists"
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
      exit 1
    fi
  done
else
  #create file, add shabang, and make the file executeable
  touch "${FILENAME}"
  echo "#!/bin/bash">>${FILENAME}
  #make the file executeable
  chmod 755 ${FILENAME}
fi

#get which editor to open it with
if [[ "${EDITOR}" == "-a" ]]
then
  atom ${FILENAME}
elif [[ "${EDITOR}" == "-v" ]]
then
  vim ${FILENAME}
else
  echo "the editor argument: '${EDITOR}' is not a valid"
  exit 1
fi
exit 0
