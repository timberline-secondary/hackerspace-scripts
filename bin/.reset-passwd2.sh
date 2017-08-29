#!/bin/bash
echo -e "\n\nEnter the student number (username) of the student who's password you want to reset:"
read username

echo -e "\n"
echo -e "wolf\nwolf" | sudo passwd $username

echo -e "\nUnless you see an error message above, the student's password has been reset to 'wolf'.  Make sure that the student changes their password the first time they login by using the 'passwd' command in a Terminal.\n"
