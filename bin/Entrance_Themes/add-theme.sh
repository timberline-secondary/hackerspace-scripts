#!/bin/bash
USERNAME=pi
HOSTNAME=pi-themes
LOCATION="/media/THEMES"

echo "Paste the link or directory to the mp3 file you want to add"
read linkdir
echo "What number do you want to give it?"
read filename

if [[ ${linkdir:0:2} == "~/" ]]
then
linkdir="${linkdir#'~'}"
linkdir=/home/$USER$linkdir
echo "$linkdir"
fi

if [[ ${linkdir:0:1} == "/" ]] || [[ ${linkdir:0:2} == "~/" ]]
then
  echo "Sending local file here@here"
  scp $linkdir ${USERNAME}@${HOSTNAME}:$LOCATION/$filename.mp3
else
  SCRIPT="cd $LOCATION; wget -O $filename.mp3 $linkdir"

  ssh -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
fi
