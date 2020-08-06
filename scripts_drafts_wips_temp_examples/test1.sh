#!/bin/bash


# all=$( find /Volumes/Macintosh\ HD/Users/alkuzmanov -mindepth 1 -maxdepth 1 -name ".[^.]*" )
# echo $all


# all2=$( ls -ld ~/[^.]* )
# echo $all2

## display symlinks as well
# ls -la ~/[^.]*

# all3=$( find /Volumes/Macintosh\ HD/Users/alkuzmanov -mindepth 1 -maxdepth 1 -name ".[^.]*" -exec ls -nls {} + )
# echo $all3
# all3=$( find /Volumes/Macintosh\ HD/Users/alkuzmanov -mindepth 1 -maxdepth 1 -name ".[^.]*" -exec ls -A1 {} + )
# echo $all3

# all4=$( find /Volumes/Macintosh\ HD/Users/alkuzmanov -mindepth 1 -maxdepth 1 -name ".[^.]*" -printf '%f\n' )
# echo $all4


# all5=$( find /Volumes/Macintosh\ HD/Users/alkuzmanov -mindepth 1 -maxdepth 1 -name ".[^.]*" -print0 | xargs -0 stat '%f/%n' )
# echo $all5

# find /Volumes/Macintosh\ HD/Users/alkuzmanov -mindepth 1 -maxdepth 1 -name ".[^.]*" -print0 | xargs -0 stat -f '%N' | sed -e 's:/./:/:'

# find ~ -mindepth 1 -maxdepth 1 -name ".[^.]*" -print0 | xargs -0 stat -f '%N' | sed s/^..................//

## working 1
# find ~ -mindepth 1 -maxdepth 1 -name ".[^.]*" -print0 | xargs -0 stat -f '%N' | sed 's/^\/.*\///'

## working 2
# find /Volumes/Macintosh\ HD/Users/alkuzmanov -mindepth 1 -maxdepth 1 -name ".[^.]*" | sed 's/^\/.*\///'


## https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html
## https://linuxize.com/post/bash-printf-command/
## https://zone.ni.com/reference/en-XX/help/371361R-01/lvconcepts/format_specifier_syntax/
## http://tldp.org/LDP/abs/html/string-manipulation.html
## https://unix.stackexchange.com/questions/104881/remove-particular-characters-from-a-variable-using-bash

## rename dotfiles replace dot with underscore
for file in *. ; do
    [[ -e ${file%.} ]] || mv "$file" "${file%.}"
done
echo Not renamed: *.

##
for file in * ; do mv -v "$file" "$(echo $file | sed 's/_/\\ /g')" ; done


## working
file=.test1
mv "$file" "_${file//.}"

##
renameDotfilesReplaceDotWithUnderscore() {
	for file in .* ; do
    	sudo mv "$file" "_${file//.}"
	done
}






