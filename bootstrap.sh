FILE="/home/$USER/.profile"
localdir="$(pwd)"


echo -e "export PATH=\$PATH:$localdir/" >> $FILE
echo "log out then back in, successfuly made 'control-panel' a linked command!"
