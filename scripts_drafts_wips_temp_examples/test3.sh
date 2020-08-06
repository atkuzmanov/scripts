#!/bin/bash

set -e
# set -u

timestamp() {
  date +"%Y-%m-%d-%H%M%S"
}

# BKP_DOTFILES_DIR=~/dotfiles-bkp-2020-07-17-170211

# 	for file in $BKP_DOTFILES_DIR/.{[^.],.?}* ; do
# 		# [ -f "$file" ] || continue
# 			# echo "$file"
# 		mv "$file" "_${file//.}"
# 	done

## https://stackoverflow.com/questions/22407480/command-to-list-all-files-except-dot-and-dot-dot
## https://unix.stackexchange.com/questions/215424/for-loop-in-bash-lists-dot-and-double-dot-folders
## https://stackoverflow.com/questions/9011233/for-files-in-directory-only-echo-filename-no-path
## https://stackoverflow.com/questions/31497323/bash-function-to-process-all-dotfiles-in-a-directory-excluding-directories

BKP_DOTFILES_DIR=~/dotfiles-bkp-2020-07-17-190504

cd $BKP_DOTFILES_DIR

for file in .[^.]* ; do
	# if [[ -е "$file" ]] ; then
	test -e "$file" &&
		sudo mv "$file" "_${file//.}"
	# fi
done

# cd "~/Documents/Drugi lichni neshta alk19890105/Rabotilnitsa-alk19890105/Hranilishta-github-alk19890105/atk2-hranilishta-lichni/dotfiles-atk2-v1.1"

# cd ~

