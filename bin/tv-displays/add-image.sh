COLOR='\033[1;31m'
RESTORE='\033[0m'
#create tmp folder for the image, will be removed in the end.




mkdir /home/$USER/tmpimage
cd /home/$USER/tmpimage
#get inputs from uploader
echo -e "${COLOR}Paste your image link:${RESTORE}"
read image_link

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
#Get the image from online
wget -O $image_name.$extension $image_link
#rename file to designated filename
cp ./$image_name.$extension ./$filename.$extension
#cp $filename $filename.png
echo "$filename"
smbclient //hightower/tv$tv -W hightower -U pi-slideshow -c "put ${filename}.$extension"
#remove tmp folder
#All done, a message for the user.
echo -e "${COLOR}All done!${RESTORE}"

rm -r /home/$USER/tmpimage
