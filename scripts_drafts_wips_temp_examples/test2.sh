#!/bin/bash

set -e

timestamp() {
  date +"%Y-%m-%d-%H%M%S"
}


BKP_DOTFILES_DIR=~/dotfiles-bkp-$(timestamp)

## create dotfiles_old in homedir


# echo -n "Creating $BKP_DOTFILES_DIR for backup of any existing current dotfiles in ~ ..."
# mkdir -p $BKP_DOTFILES_DIR
# echo "done"


## copy current dotfiles in bkp dir
# CURRENT_DOTFILES=$(find "/Volumes/Macintosh HD/Users/alkuzmanov" -mindepth 1 -maxdepth 1 -name ".[^.]*")
# echo $CURRENT_DOTFILES

# declare -a my_array
# while IFS=  read -r -d $'\0'; do
#     my_array+=("$REPLY")
# done < <(find /Volumes/Macintosh\ HD/Users/alkuzmanov -mindepth 1 -maxdepth 1 -name ".[^.]*" -print0)


declare -a CURRENT_DOTFILES_ARRAY
while IFS=  read -r -d '' n; do
	if ! [[ "$n" =~ .*"Trash".* || "$n" =~ .*"DS_Store".* || "$n" = .[^.] ]]; then
    	CURRENT_DOTFILES_ARRAY+=("$n")
    fi
done < <(find /Volumes/Macintosh\ HD/Users/alkuzmanov -mindepth 1 -maxdepth 1 -name ".*" ! -type l -print0)

# echo ${my_array[@]}

# for current_dotfile in $CURRENT_DOTFILES ;
for current_dotfile in "${CURRENT_DOTFILES_ARRAY[@]}" ;
do
	cp -r "$current_dotfile" $BKP_DOTFILES_DIR

	# if ! [[ "$current_dotfile" =~ .*"Trash".* || "$current_dotfile" =~ .*"DS_Store".* ]]; then
		# echo $current_dotfile
	# fi
done




