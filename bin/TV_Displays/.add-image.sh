COLOR='\033[1;31m'
RESTORE='\033[0m'
WARNING='\033[1;33m'
FEEDBACK='\033[0;36m'
#create tmp folder for the image, will be removed in the end.

smbclient_check=$(dpkg -l | grep "ii  smbclient")
echo $smbclient_check
if [[ $smbclient_check == "" ]]; then
  echo "You are missing packages that are required to run this script, hackerspace_admin password required to install:"
  cd ..
  su -c "sudo -S ./.dialoginstall.sh" -m hackerspace_admin
  exit
fi

tmpfolder=$(pwd)/tmpimage
if [ -e "$tmpfolder" ]; then
  rm -r ./tmpimage
fi
mkdir ./tmpimage
cd ./tmpimage
#get inputs from uploader
echo -e "${COLOR}Paste your image link(${WARNING}must be https link${COLOR}), or specify exact local directory(${WARNING}must begin with "/"${COLOR}):${RESTORE}"
read image_link
#chane "~" to "/home/$USER"
if [[ ${image_link:0:2} == "~/" ]]; then
  linkdir="${image_link#'~'}"
  linkdir=/home/$USER$image_link
fi
#give feedback based on what is submitted by user, a file, or link.
if [[ ${image_link:0:4} == "http" ]]; then
  echo -e "${FEEDBACK} IMAGE LINK DETECTED! ${RESTORE}"
fi

if [[ ${image_link:0:1} == "/" ]]; then
  echo -e "${FEEDBACK} FILE DETECTED! ${RESTORE}"
fi
if [[ ${image_link:0:2} == "~/" ]]; then
  echo -e "${FEEDBACK} FILE DETECTED! ${RESTORE}"
fi
# check extension for later percautions and to avoid file corruption.
url_filename=$(basename "$image_link")
extension="${url_filename##*.}"
original_linkname_with_extension="${image_link##*/}"
original_linkname="${original_linkname_with_extension%.*}"



echo -e "${COLOR}Student Number:${RESTORE}"
read student_number

echo -e "${COLOR}Name your image (ex. Mountains) or press enter to keep orriginal:${RESTORE}"
read image_name

echo -e "${COLOR}Which TV? (1-4):${RESTORE}"
read tv
#declare filename format
filename="${student_number}.z.${image_name}"
#Get the image from online, or copy local file to local directory.
if [[ ${image_link:0:4} == "http" ]]; then

  wget -O $image_name.$extension $image_link
fi
if [[ ${image_link:0:1} == "/" ]]; then
  cp $image_link ./$image_name.$extension
fi
if [[ ${image_link:0:1} == "~/" ]]; then
  cp $image_link ./$image_name.$extension
fi
#rename file to designated filename
if [[ $image_name == "" ]]; then
  original_linkname_with_extension="${image_link##*/}"
  original_linkname="${original_linkname_with_extension%.*}"
  cp ./$original_linkname_with_extension ./$filename.$extension
else
  cp ./$image_name.$extension ./$filename.$extension
fi
#cp $filename $filename.png
echo "$filename will now be uploaded, enter desired password:"
smbclient //hightower/tv$tv -W hightower -U pi-slideshow -c "put ${filename}.$extension"
#remove tmp folder
#All done, a message for the user.
echo -e "${COLOR}All done!${RESTORE}"
cd ..
rm -r ./tmpimage
