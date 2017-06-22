COLOR='\033[1;31m'
RESTORE='\033[0m'
WARNING='\033[1;33m'
FEEDBACK='\033[0;36m'
#create tmp folder for the image, will be removed in the end.




mkdir ./tmpimage
cd ./tmpimage
#get inputs from uploader
echo -e "${COLOR}Paste your image link(${WARNING}must be https link${COLOR}), or specify exact local directory(${WARNING}must begin with "/"${COLOR}):${RESTORE}"
read image_link
#give feedback based on what is submitted by user, a file, or link.
if [[ ${image_link:0:5} == "https" ]]
then
  echo -e "${FEEDBACK} IMAGE LINK DETECTED! ${RESTORE}"
fi
if [[ ${image_link:0:1} == "/" ]]
then
  echo -e "${FEEDBACK} FILE DETECTED! ${RESTORE}"
fi
# check extension for later percautions and to avoid file corruption.
url_filename=$(basename "$image_link")
extension="${url_filename##*.}"

echo -e "${COLOR}Student Number:${RESTORE}"
read student_number

echo -e "${COLOR}Name your image (ex. Mountains):${RESTORE}"
read image_name

echo -e "${COLOR}Which TV? (1-4):${RESTORE}"
read tv
#declare filename format
filename="${student_number}.z.${image_name}"
#Get the image from online, or copy local file to local directory.
if [[ ${image_link:0:5} == "https" ]]
then
  wget -O $image_name.$extension $image_link
fi
if [[ ${image_link:0:1} == "/" ]]
then
  cp $image_link ./$image_name.$extension
fi
#rename file to designated filename
cp ./$image_name.$extension ./$filename.$extension
#cp $filename $filename.png
echo "$filename will now be uploaded, enter desired password:"
smbclient //hightower/tv$tv -W hightower -U pi-slideshow -c "put ${filename}.$extension"
#remove tmp folder
#All done, a message for the user.
echo -e "${COLOR}All done!${RESTORE}"
cd ..
rm -r ./tmpimage
