#!/bin/bash
echo "*******************************"
echo "* Activating Missile Launcher *"
echo "*******************************"

# how can we just put the script here instead of a seperate file?
# su -c "sudo -S ./.launchStage2.sh" -m hackerspace_admin

if ! [ hackerspace_admin = "$USER" ] && ! [ root = "$USER" ]; then
    su -c "$0" -m hackerspace_admin
elif ! [ root = "$USER" ]; then
    sudo "$0"
else
    source /root/pyusb/bin/activate
    cd /root/pyusb
    python stormLauncher.py
    deactivate
    cd ~
fi
