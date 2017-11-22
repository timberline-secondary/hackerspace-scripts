#############################
#
# Author: Peder Skaaravik
# Date: November 20, 2017
# Dev. Stage: Testing - final stages
#
#############################

import os
import getpass

print("\n")
print("  **************************")
print("  *       ADD IMAGE        *")
print("  **************************")

pwd = os.getcwd()

# create tmp folder with image (will be removed after completion)

tmp_folder = pwd + "/tmpimage"

if os.path.exists(tmp_folder):
    os.system("rm -r " + tmp_folder)

os.system("mkdir " + tmp_folder)
os.system("cd ./tmpimage")

while True:
    image_link = input(
        "Paste your image link (must start with https), or specify exact directory with extension (.png,.jpg,etc..) \n")
    if image_link == 'q':
        break
    ext = image_link[-4:]
    if image_link[0:2] == "~/":
        image_link = image_link.replace("~/", "/home/" + getpass.getuser() + "/", 1)

    print(image_link)

    if image_link[0:4] == "http":
        print("LINK DETECTED")

    student_number = input("Enter Student Number\n")

    image_name = input("Name your image (MUST NAME IF YOU USED URL) or press Enter to keep original\n")

    tv = input("What TV are you sending this to?\n")

    filename = student_number + ".z." + image_name + ext

    if image_link[0:4] == "http":
        image_name = image_name + ext
        os.system("wget -O " + image_name + ' ' + image_link)
        print("LINK NAMED BOY   " + image_name)

    if image_name == '' and image_link[0:1] == "/":
        original_filename = os.path.basename(image_link)
        filename = student_number + ".z." + original_filename
        os.system("cp " + image_link + " ./" + filename)
    elif image_link[0:1] == "/":
        os.system("cp " + image_link + " ./" + filename)
    else:
        os.system("cp " + image_name + " ./" + filename)

    print("$filename will now be uploaded, enter desired password:\n")

    os.system("smbclient //hightower/tv" + tv + " -W hightower -U pi-slideshow -c \"put " + filename + "\"")

os.system("rm -r " + tmp_folder)
os.system("rm -r ./" + filename)
os.system("rm -r ./" + image_name)
