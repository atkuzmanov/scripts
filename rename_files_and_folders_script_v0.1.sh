#!/bin/bash

set -e

################################

declare -a STRINGS_TO_REPLACE
# STRINGS_TO_REPLACE+=("$n")


    for current_string in "${STRINGS_TO_REPLACE[@]}" ;
    do
    	echo $current_string
    done


################################

## https://unix.stackexchange.com/questions/139363/recursively-iterate-through-files-in-a-directory
## https://askubuntu.com/questions/266179/how-to-exclude-ignore-hidden-files-and-directories-in-a-wildcard-embedded-find

while IFS=  read -r -d '' n; do
    
    # test -f "$n" || echo "$n is not a file."
    # test -d "$n" || echo "$n is not a directory."
    echo "$n"
done < <(find . \( ! -regex '.*/\..*' \) -type f -print0)
    

################################

################################
    
    ## maybe use this if recursive is not needed
    ## or use find and add mindepth and maxdepth
    # for f in * ;
    # do
    # done

################################
