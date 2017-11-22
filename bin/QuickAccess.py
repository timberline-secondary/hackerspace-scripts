#########################################
#
# Author: Peder Skaaravik
# Date: November 20, 2017
# Dev. Stage: undergoing developement
#
#########################################

import os
from tkinter import *
from time import sleep


print("\n")
print("  ***************************  ")
print("  * WELCOME TO QUICK ACCESS *  ")
print("  *                         *  ")
print("  *   THE NEW SCRIPT BUDDY  *  ")
print("  ***************************  ")
sleep(2)
root = Tk()
frame = Frame(root)
frame.grid()
root.title("CONTROL PANEL v2.0")
root.geometry("400x400")
frame.pack()
cwd = os.getcwd()


class Control:
    buttons = []

    def openFile(self, b_ID):
         print(b_ID)
         if b_ID[-3:] == ".py":
            os.system("gnome-terminal -x bash -c \"echo -e \'#Running#\n\'; python3 " + b_ID + ";bash\"")
         else:
            os.system("gnome-terminal -x bash -c \"echo -e \'#Running#\n\'; bash " + b_ID + ";bash\"")

    def gen(self, button_count, file_index):

         for root, directories, filenames in os.walk(cwd):

#UN-COMMENT TO DISPLAY DIRECTORY BUTTONS - *hint* they dont have any use yet. so don't do it...
        #     for directory in directories:
        #         directory = os.path.join(root, directory)
        #         self.buttons.append(Button(frame, text=directory, fg="black",command=lambda directory=directory: self.openFile(directory)))
        #         self.buttons[button_count].grid(row=button_count+1)
        #         file_index += 1
        #         button_count += 1

            for filename in filenames:
                 if filename.startswith('.'):
                     continue
                 else:
                    name = filename
                    button_count += 1
                    filename = os.path.join(root, filename)
                    self.buttons.append(Button(frame, text=name, background="black",fg="red",command=lambda filename=filename: self.openFile(filename)))
                    self.buttons[button_count].grid(row=button_count+1)

x = Control()
x.gen(-1, -1)
root.mainloop()

