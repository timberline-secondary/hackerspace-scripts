#!/bin/bash
echo "*******************************"
echo "* Activating Missile Launcher *"
echo "*******************************"

# how can we just put the script here instead of a seperate file?
su -c "sudo -S .launchStage2.sh" -m hackerspace_admin
