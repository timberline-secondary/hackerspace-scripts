#########################################
#
# Author: Peder Skaaravik / Tylere
# Date: November 20, 2017
# Dev. Stage: undergoing developement
#
#########################################


import os
import getpass
import signal

USERNAME = "pi"
HOSTNAME = "pi-themes"
LOCATION = "/media/THEMES"  # mp3 file destination
linkdir = ""

print("\n")
print("  **************************")
print("  * ENTRANCE THEME PLAYER  *")
print("  **************************")

while True:
    source = input("\nPaste the link or directory to the mp3 file you want to add, or type q to quit:\n")
    if source == 'q':
        break

    original_filename = os.path.basename(source)
    filename = input("\nWhat number do you want to give it? Press [Enter] to keep '" + original_filename + "'\n")

    # keeps original file name if filename is left blank
    if filename == "":
        filename = original_filename
    else:
        filename += ".mp3"

    # replace with absolute directory if user uses "~/"
    if source[0:2] == "~/":
        source = source.replace("~/", "/home/" + getpass.getuser() + "/", 1)

    # send to pi
    print("Sending file... if it asks, default password is: raspberry\n")
    if source[0] == "/":  # use scp to transfer local files
        bash_command = "scp "+source+" "+USERNAME+"@"+HOSTNAME+":"+LOCATION+"/"+filename
    else:  # use wget to download files form url
        bash_command = "ssh -l "+USERNAME+" "+HOSTNAME+" \"cd "+LOCATION+"; wget -O "+filename+" "+source+"\""

    os.system(bash_command)

# Close the terminal window
# https://stackoverflow.com/questions/34389322/how-to-exit-linux-terminal-using-python-script
os.kill(os.getppid(), signal.SIGHUP)
