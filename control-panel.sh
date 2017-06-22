#!/bin/bash

running=1
n=0
chmod +x ".dialoginstall.sh"
DIALOG_CANCEL=1

# check if

dialog_check=$(dpkg -l | grep "ii  dialog")
echo $dialog_check
if [[ $dialog_check = "" ]]
then
  echo "You are missing the `dialog` package to run this script, hackerspace_admin password required to install:"
su -c "sudo -S ./.dialoginstall.sh" -m hackerspace_admin
  exit
fi


# Scripts bin dir is relative to the control-panel.sh (pwd=present working directory)
SCRIPT_DIR="$(pwd)/bin/"
working_dir=$SCRIPT_DIR
#old functions for minigames, now seperate scripts.
# function coinflip() {
#   clear
#   echo "Flipping a coin..."
#   echo ""
#   echo "         _"
#   sleep 0.2
#   clear
#   echo "Flipping a coin..."
#   echo "         _"
#   echo ""
#   sleep 0.2
#   clear
#   echo "Flipping a coin..."
#   echo "         \\"
#   echo ""
#   sleep 0.2
#   clear
#   echo "Flipping a coin..."
#   echo "         -"
#   echo ""
#   sleep 0.2
#   clear
#   echo "Flipping a coin..."
#   echo "         /"
#   echo ""
#   sleep 0.2
#   clear
#   echo "Flipping a coin..."
#   echo "         -"
#   echo ""
#   sleep 0.2
#   clear
#   echo "Flipping a coin..."
#   echo ""
#   echo "         \\"
#   sleep 0.2
#   clear
#   echo "Flipping a coin..."
#   echo ""
#   echo "         _"
#   sleep 2
#   clear
#   echo "The coin says..."
#   BINR=$(( ( RANDOM % 2 )  + 0 ))
#   if [ $BINR == 1 ]
#   then
#   AYS="HEADS"
#   fi
#   if [ $BINR == 0 ]
#   then
#   AYS="TAILS"
#   fi
#   sleep 2
#   echo "     _____ "
#   echo "    /"$AYS"\\"
#   echo "    \\_____/"
#   echo "    \\|||||/"
#   beep -f $((( RANDOM % 1000 )+ 300)) -d 0 -l 500
#   sleep 1.5
#   echo "Press "b" to return to control-panel"
#   read -rsn1 input
# if ["$input" = "b"]; then
#     echo "Better luck next time"
# fi
# }
# function microwave() {
#
#   clear
#   echo "What would you like to microwave?"
#   echo " "
#   echo "1) Pizza 2) Ramen 3) Hot Dog"
#   echo "4) S'mores       5) Tin Foil"
#   echo " "
#   read -p ">> " ans
#   case $ans in
#     1)
#      clear
#      echo " _________"
#      echo "|.----.|__|"
#      echo "|| <] ||++|"
#      echo "|'----'|__|"
#      sleep 2
#      clear
#      echo " _________"
#      echo "|.----.|3_|"
#      echo "|| <] ||++|"
#      echo "|'----'|__|"
#      beep -f 200 -d 0 -l 5 -r 10
#      sleep 0.2
#      clear
#      echo " _________"
#      echo "|.----.|30|"
#      echo "|| <] ||++|"
#      echo "|'----'|__|"
#      beep -f 200 -d 0 -l 5 -r 10
#      sleep 1
#      tmr=30
#      for run in {30..10}
#      do
#       clear
#       echo " _________"
#       echo "|.----.|"$tmr"|"
#       echo "|| <] ||++|"
#       echo "|'----'|__|"
#       beep -f 50 -l 1000
#       ((tmr--))
#      done
#      for run in {9..0}
#      do
#       clear
#       echo " _________"
#       echo "|.----.|0"$tmr"|"
#       echo "|| <] ||++|"
#       echo "|'----'|__|"
#       beep -f 50 -l 1000
#       ((tmr--))
#      done
#      clear
#      echo " _________"
#      echo "|.----.|00|"
#      echo "|| <] ||++|"
#      echo "|'----'|__|"
#      beep -f 1000 -l 500
#      sleep 1
#      beep -f 1000 -l 500
#      sleep 1
#      beep -f 1000 -l 500
#      sleep 1
#      sleep 1.5
#      echo "Press "b" to return to control-panel"
#      read -rsn1 input
#    if ["$input" = "b"]; then
#        echo "Better luck next time"
#    fi
#      exit
#      ;&
#
#     2)
#      clear
#      echo " _________"
#      echo "|.----.|__|"
#      echo "||[~~]||++|"
#      echo "|'----'|__|"
#      sleep 2
#      clear
#      echo " _________"
#      echo "|.----.|3_|"
#      echo "||[~~]||++|"
#      echo "|'----'|__|"
#      beep -f 200 -d 0 -l 5 -r 10
#      sleep 0.2
#      clear
#      echo " _________"
#      echo "|.----.|30|"
#      echo "||[~~]||++|"
#      echo "|'----'|__|"
#      beep -f 200 -d 0 -l 5 -r 10
#      sleep 1
#      tmr=30
#      for run in {30..10}
#      do
#       clear
#       echo " _________"
#       echo "|.----.|"$tmr"|"
#       echo "||[~~]||++|"
#       echo "|'----'|__|"
#       beep -f 50 -l 1000
#       ((tmr--))
#      done
#      for run in {9..0}
#      do
#       clear
#       echo " _________"
#       echo "|.----.|0"$tmr"|"
#       echo "||[~~]||++|"
#       echo "|'----'|__|"
#       beep -f 50 -l 1000
#       ((tmr--))
#      done
#      clear
#      echo " _________"
#      echo "|.----.|00|"
#      echo "||[~~]||++|"
#      echo "|'----'|__|"
#      beep -f 1000 -l 500
#      sleep 1
#      beep -f 1000 -l 500
#      sleep 1
#      beep -f 1000 -l 500
#      sleep 1
#      exit
#      ;&
#      sleep 1.5
#      echo "Press "b" to return to control-panel"
#      read -rsn1 input
#    if ["$input" = "b"]; then
#        echo "Better luck next time"
#    fi
#
#     3)
#      clear
#      echo " _________"
#      echo "|.----.|__|"
#      echo "|| [|]||++|"
#      echo "|'----'|__|"
#      sleep 2
#      clear
#      echo " _________"
#      echo "|.----.|3_|"
#      echo "|| [|]||++|"
#      echo "|'----'|__|"
#      beep -f 200 -d 0 -l 5 -r 10
#      sleep 0.2
#      clear
#      echo " _________"
#      echo "|.----.|30|"
#      echo "|| [|]||++|"
#      echo "|'----'|__|"
#      beep -f 200 -d 0 -l 5 -r 10
#      sleep 1
#      tmr=30
#      for run in {30..10}
#      do
#       clear
#       echo " _________"
#       echo "|.----.|"$tmr"|"
#       echo "|| [|]||++|"
#       echo "|'----'|__|"
#       beep -f 50 -l 1000
#       ((tmr--))
#      done
#      for run in {9..0}
#      do
#       clear
#       echo " _________"
#       echo "|.----.|0"$tmr"|"
#       echo "|| [|]||++|"
#       echo "|'----'|__|"
#       beep -f 50 -l 1000
#       ((tmr--))
#      done
#      clear
#      echo " _________"
#      echo "|.----.|00|"
#      echo "|| [|]||++|"
#      echo "|'----'|__|"
#      beep -f 1000 -l 500
#      sleep 1
#      beep -f 1000 -l 500
#      sleep 1
#      beep -f 1000 -l 500
#      sleep 1
#      exit
#      ;&
#      sleep 1.5
#      echo "Press "b" to return to control-panel"
#      read -rsn1 input
#    if ["$input" = "b"]; then
#        echo "Better luck next time"
#    fi
#
#     4)
#      clear
#      echo " _________"
#      echo "|.----.|__|"
#      echo "|| == ||++|"
#      echo "|'----'|__|"
#      sleep 2
#      clear
#      echo " _________"
#      echo "|.----.|3_|"
#      echo "|| == ||++|"
#      echo "|'----'|__|"
#      beep -f 200 -d 0 -l 5 -r 10
#      sleep 0.2
#      clear
#      echo " _________"
#      echo "|.----.|30|"
#      echo "|| == ||++|"
#      echo "|'----'|__|"
#      beep -f 200 -d 0 -l 5 -r 10
#      sleep 1
#      tmr=30
#      for run in {30..10}
#      do
#       clear
#       echo " _________"
#       echo "|.----.|"$tmr"|"
#       echo "|| == ||++|"
#       echo "|'----'|__|"
#       beep -f 50 -l 1000
#       ((tmr--))
#      done
#      for run in {9..0}
#      do
#       clear
#       echo " _________"
#       echo "|.----.|0"$tmr"|"
#       echo "|| == ||++|"
#       echo "|'----'|__|"
#       beep -f 50 -l 1000
#       ((tmr--))
#      done
#      clear
#      echo " _________"
#      echo "|.----.|00|"
#      echo "|| == ||++|"
#      echo "|'----'|__|"
#      beep -f 1000 -l 500
#      sleep 1
#      beep -f 1000 -l 500
#      sleep 1
#      beep -f 1000 -l 500
#      sleep 1
#      exit
#      ;&
#      sleep 1.5
#      echo "Press "b" to return to control-panel"
#      read -rsn1 input
#    if ["$input" = "b"]; then
#        echo "Better luck next time"
#    fi
#
#     5)
#      clear
#      echo " _________"
#      echo "|.----.|__|"
#      echo "||<^><||++|"
#      echo "|'----'|__|"
#      sleep 2
#      clear
#      echo " _________"
#      echo "|.----.|3_|"
#      echo "||<^><||++|"
#      echo "|'----'|__|"
#      beep -f 200 -d 0 -l 5 -r 10
#      sleep 0.2
#      clear
#      echo " _________"
#      echo "|.----.|30|"
#      echo "||<^><||++|"
#      echo "|'----'|__|"
#      beep -f 200 -d 0 -l 5 -r 10
#      sleep 1
#      tmr=30
#      for run in {30..25}
#      do
#       clear
#       echo " _________"
#       echo "|.----.|"$tmr"|"
#       echo "||<^><||++|"
#       echo "|'----'|__|"
#       beep -f 50 -l 5 -d 0 -r 100
#       ((tmr--))
#      done
#      clear
#      echo "    .   _"
#      echo "   23vxxas"
#      echo " >553eSD34|"
#      echo "|XFDADSff3|"
#      echo ""
#      echo "Oh no! You blew up the microwave!"
#      freq=1000
#      for run in {1000..200}
#      do
#       beep -f $freq -l 1
#       ((freq--))
#      done
#      sleep 1.5
#      echo "Press "b" to return to control-panel"
#      read -rsn1 input
#    if ["$input" = "b"]; then
#        echo "Better luck next time"
#    fi
#      exit
#      ;&
#   esac
# }
function rundialog() {
  wa=()  # define working array to fold content of working_dir (scripts and subdirs)
  wa2=() # wa but with fully qualified dir structure
  i=0
  echo $(pwd)
  working_dir=$1
  cd $working_dir
  echo $(pwd)

  while read -r line; do # process file by file
    let i=$i+1
    wa+=($i "$line")
  done < <(ls -1 $working_dir) #list current directory in the dialog that follows. ## ${wa[@]} ##

  dialog=$(dialog --title "$working_dir" --cancel-label "Quit" --menu "Pick something." 24 80 17 "${wa[@]}" \
    "Back" ".." 3>&2 2>&1 1>&3) # show dialog menu

  exitstatus=$?
  case $exitstatus in
    $DIALOG_CANCEL)
      echo "Goobye!"
      exit
      ;;
  esac

  case $dialog in

    ####### 1-999, looks like you're out of luck if you reach over 999 scripts and directories....
    Microwave)
    microwave
    ;;
    Coinflip)
    coinflip
    ;;
    Back)
      cd ..
      working_dir=$(pwd)
      rundialog $working_dir
      ;;

    [1-999])

      item=$(($dialog*2 - 1))

      ######## this dialogue will happen after clicking enter on desired stuff ^

      ######## if its a directory, cd into direcotry, if not, then run the .sh file.
      if
        [ -d "${wa[$item]}" ]
      then
        echo "$working_dir/${wa[$item]}"
        rundialog $working_dir/${wa[$item]}
        # cd ./${wa[$item]}
        # while read -r line; do # process file by file
        #   let n=$n+1
        #   w+=($n "$line")
        # done < <(ls -1 ./)
        #
        # dir=$(dialog --title "New directory" --menu "Choose something" 24 80 17 "${w[@]}" \
        #   3>&2 2>&1 1>&3)

      else

        gnome-terminal -x bash -c "echo -e '# Running ${wa[$item]} # \n'; bash $working_dir/${wa[$item]};bash"
      fi

      ;;
    DIALOG_CANCEL) ;;
  esac

}

clear
echo "***************************************"
echo "*                                     *"
echo "*   WELCOME TO PEDERS CONTROL-PANEL!  *"
echo "*                                     *"
echo "***************************************"
echo " "
sleep 0.5

until [ $running = 0 ]; do
   rundialog $working_dir

done
#rundialog $working_dir
# #
# until [ $running = 0 ]; do
#    rundialog $working_dir
# done
