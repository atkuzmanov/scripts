#!/bin/bash

set -e

################################

declare -a STRINGS_TO_REPLACE
STRINGS_TO_REPLACE=("alk8915" "alk198915")
# STRINGS_TO_REPLACE+=("$n")
# for current_string in "${STRINGS_TO_REPLACE[@]}" ;
# do
#     echo $current_string
# done

################################

## https://unix.stackexchange.com/questions/139363/recursively-iterate-through-files-in-a-directory
## https://askubuntu.com/questions/266179/how-to-exclude-ignore-hidden-files-and-directories-in-a-wildcard-embedded-find
## https://stackoverflow.com/questions/229551/how-to-check-if-a-string-contains-a-substring-in-bash
## https://superuser.com/questions/701805/nix-find-type-flag-can-it-accept-multiple-types

rename_files_and_folders() {
    while IFS= read -r -d '' n; do

        # if [[ "$n" == *"alk19890105"* ]]; 
        # then
        #     echo "Skipping $n"
        # else
        #     for current_string in "${STRINGS_TO_REPLACE[@]}" ;
        #     do
        #         if [[ "$n" == *"$current_string"* ]]; 
        #         then
        #             echo $n
        #         fi
        #     done
        # fi

        echo "$n"
    # done < <(find . \( ! -regex '.*/\..*' ! -iname ".*" -type d -o -type f \) -print0)
    done < <(find . \( -type d -path '*/\.*' -prune -o -not -name '.*' \) -print0)
    # done < <(find . \( ! -regex '.*/\..*'  ! -iname ".*" -type d -o -type f \) -print0)
}

rename_files_and_folders

################################

test_f1() {
    echo "test"
}

# test_f1

################################
    
    ## maybe use this if recursive is not needed
    ## or use find and add mindepth and maxdepth
    # for f in * ;
    # do
        # test -f "$n" || echo "$n is not a file."
        # test -d "$n" || echo "$n is not a directory."
    # done

################################
