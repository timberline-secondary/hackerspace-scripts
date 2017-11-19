#!/bin/bash

########################################
# New Peder version
########################################


#colors:
COLOR='\033[1;31m'
RESTORE='\033[0m'

echo -e "${COLOR}First name:${RESTORE}"
read first_name
echo -e "${COLOR}Last name:${RESTORE}"
read last_name
echo -e "${COLOR}Grad year:${RESTORE}"
read year
echo -e "${COLOR}Student number:${RESTORE}"
read student_number

# declare a subject (\046 is ampersand '&' character)
subjects=("Digital Art" "Digital Photography" "3D Modelling & Animation")

echo -e "${COLOR}Subject:"

for i in "${!subjects[@]}"; do
    echo -e "${COLOR} ${i}) ${subjects[$i]}${RESTORE}"
done
    	
read subject_index

# which TV?
echo -e "${COLOR}Which TV? (1-4):${RESTORE}"
read tv

# need the Student number so files are sorted together, and the a so when alpha-sorted
# this title image will come first.
filename="${student_number}.a.${first_name}${last_name}"

cp Template.svg ${filename}.svg

# Replace the template text with the data provided in a copy of the Template.svg
sed -i -e "s/FIRSTNAME LASTNAME/${first_name} ${last_name}/g" ${filename}.svg
sed -i -e "s/YYYY/${year}/g" ${filename}.svg
# the fancy //&/\\& stuff is to deal with ampersands so they don't act as a command
sed -i -e "s/SUBJECT/${subjects[$subject_index]//&/\\&amp;}/g" $filename.svg

#convert to .png
inkscape -z -e ${filename}.png -w 1920 -h 1080 ${filename}.svg 

# put the image in the network share that is read by the TV
# cp ${filename}.png

smbclient //hightower/tv$tv -W hightower -U pi-slideshow -c "put ${filename}.png"

# remove local copies
rm ${filename}.svg
rm ${filename}.png

