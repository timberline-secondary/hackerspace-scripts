#!/bin/bash

running=1
n=0
# test comment
DIALOG_CANCEL=1

# Scripts bin dir is relative to the control-panel.sh (pwd=present working directory)
SCRIPT_DIR="$(pwd)/bin/"
working_dir=$SCRIPT_DIR

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
  done < <(ls -1 $working_dir/) #list current directory in the dialog that follows. ## ${wa[@]} ##

  dialog=$(dialog --title "$working_dir/" --cancel-label "Quit" --menu "Pick something." 24 80 17 "${wa[@]}" \
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

#rundialog $working_dir
#
until [ $running = 0 ]; do
  rundialog $working_dir
done
