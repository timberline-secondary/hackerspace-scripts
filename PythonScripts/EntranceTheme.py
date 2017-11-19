
import os
import sys
import getpass

#change settings to your network
USERNAME = "pi" #insert username that you log onto the host with.
HOSTNAME = "192.168.0.10"  #insert host name
LOCATION = "/home/pi/media/THEMES" #file destination
linkdir = ""
yesChoice = ['yes', 'y']
noChoice = ['no', 'n']

while True:
    # declare mp3 directory or direct download link
    print("Paste the link or directory to the mp3 file you want to add")
    linkdir = sys.stdin.readline()
    linkdir = linkdir.replace('\n', '', 1)

    # declare new file name.
    print("What number do you want to give it?")
    filename = sys.stdin.readline()
    filename = filename.replace('\n', '', 1)

    #replace with propper format if user uses "~/"
    if linkdir[0:2] == "~/":
        linkdir = linkdir.replace("~/", "/home/"+ getpass.getuser() +"/", 1)
        filename = filename + ".mp3"

    # send to pi
    if linkdir[0] == "/":
        print("Sending file.. default password is: live")  #change default password
        bash_command = "scp "+ linkdir+' '+USERNAME+"@"+HOSTNAME+":"+LOCATION+"/"+filename
        os.system(bash_command)
    else:
        os.system("ssh -l "+USERNAME+" "+HOSTNAME + " \"cd "+LOCATION+"; wget -O "+filename+ ' '+linkdir+"\"")

    loop_answer = raw_input("would you like to send another entrance theme? (yes/no)")
    if loop_answer == "yes" or loop_answer == "y":
        continue
    else:
        break
