#!/bin/bash
USERNAME=pi
HOSTNAME=pi-themes
LOCATION="/media/THEMES"

echo "Paste the link to the mp3 file you want to add"
read url
echo "What number do you want to give it?"
read filename

SCRIPT="cd $LOCATION; wget -O $filename.mp3 $url"

ssh -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
