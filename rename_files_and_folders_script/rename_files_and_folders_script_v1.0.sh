#!/bin/bash

set -e

################################
## WORKING
##
## TODO: optimise
##
## WIP: [optimisation 1:]
## Instead of each function looping and going through all files and folders
## have one function to do the loop and pass the files and folders as arguments
## to all the other functions.
## Continue developing function `rename_files_and_folders_dirs_1`.
##
## [optimisation 2:]
## Expand features to take user input.
## For example call the script with flags/arguments/parameters/options
## which invoke different functions passing different arguments 
## such as tags to remove or tags to add.
## Note: This could likely make [optimisation 1:] redundant, so need to choose
## witch path to follow.
##
## References
## https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion
## https://stackoverflow.com/questions/15012631/rename-files-and-directories-recursively-under-ubuntu-bash
## https://superuser.com/questions/213134/recursively-rename-files-change-extension-in-linux
## https://stackoverflow.com/questions/6509650/extract-directory-from-path
## https://stackoverflow.com/questions/6121091/get-file-directory-path-from-file-path/6121114
## https://stackoverflow.com/questions/13210880/replace-one-substring-for-another-string-in-shell-script
## https://tldp.org/LDP/abs/html/string-manipulation.html
## https://stackoverflow.com/questions/16623835/remove-a-fixed-prefix-suffix-from-a-string-in-bash
## https://unix.stackexchange.com/questions/311758/remove-specific-word-in-variable
## https://unix.stackexchange.com/questions/56810/adding-text-to-filename-before-extension
## https://stackoverflow.com/questions/45799657/bash-adding-a-string-to-file-name
## https://linuxize.com/post/bash-functions/
## https://bash.cyberciti.biz/guide/Pass_arguments_into_a_function
## https://stackoverflow.com/questions/6212219/passing-parameters-to-a-bash-function
## https://linuxacademy.com/blog/linux/conditions-in-bash-scripting-if-statements/
################################

declare -a STRINGS_TO_REPLACE
STRINGS_TO_REPLACE=("tag1" "tag2")

STRING_TO_ADD_IF_NOT_PRESENT="tag3"

################################

rename_files_remove_old_tags_arguments() {
    filepathnodot="${1#.}"
    # echo "$filepathnodot"

    justfilenamenopath="${1##*/}"
    # echo "$justfilenamenopath"

    justpathnofile=${1%/*}
    # echo "$justpathnofile"

    for current_string in "${STRINGS_TO_REPLACE[@]}" ;
    do
        if [[ "$justfilenamenopath" == *"$current_string"* ]]; 
        then
            # echo "Will rename $justfilenamenopath"
            test -e "$1" &&
                newfilename=$(echo "$justfilenamenopath" | sed "s/$current_string//g")
                mv -v "$1" "$justpathnofile/$newfilename"
            break;
        fi
    done
}

rename_files_remove_old_tags_arguments

################################

rename_files_remove_old_tags() {
    while IFS= read -r -d '' n; do

        filepathnodot="${n#.}"
        # echo "$filepathnodot"

        justfilenamenopath="${n##*/}"
        # echo "$justfilenamenopath"

        justpathnofile=${n%/*}
        # echo "$justpathnofile"

        for current_string in "${STRINGS_TO_REPLACE[@]}" ;
        do
            if [[ "$justfilenamenopath" == *"$current_string"* ]]; 
            then
                # echo "Will rename $justfilenamenopath"
                test -e "$n" &&
                    newfilename=$(echo "$justfilenamenopath" | sed "s/$current_string//g")
                    mv -v "$n" "$justpathnofile/$newfilename"
                break;
            fi
        done
    done < <(find . \( -type f -name "[!.]*" \) -print0)
}

rename_files_remove_old_tags

################################

rename_folders_dirs_remove_old_tags() {
    while IFS= read -r -d '' n; do
        for current_string in "${STRINGS_TO_REPLACE[@]}" ;
        do
            if [[ "$n" == *"$current_string"* ]]; 
            then
                # echo "Will rename $n"
                test -e "$n" &&
                    newfilename=$(echo "$n" | sed "s/$current_string//g")
                    mv -v "$n" "$newfilename"
                break;
            fi
        done
    done < <(find . \( -type d -name "[!.]*" \) -print0)
}

rename_folders_dirs_remove_old_tags

################################

rename_files_add_new_tags() {
    while IFS= read -r -d '' n; do
        
        filepathnodot="${n#.}"
        # echo "$filepathnodot"

        justfilenamenopath="${n##*/}"
        # echo "$justfilenamenopath"

        justpathnofile=${n%/*}
        # echo "$justpathnofile"

        if [[ ! "$justfilenamenopath" == *"$STRING_TO_ADD_IF_NOT_PRESENT"* ]]; 
        then
            # echo "Will rename $justfilenamenopath"
            test -e "$n" &&
                newfilename="${justfilenamenopath%.*} $STRING_TO_ADD_IF_NOT_PRESENT.${justfilenamenopath##*.}"
                mv -v "$n" "$justpathnofile/$newfilename"
        fi
    done < <(find . \( -type f -name "[!.]*" \) -print0)
}

rename_files_add_new_tags

################################

rename_folders_dirs_add_new_tags() {
    while IFS= read -r -d '' n; do
        
        filepathnodot="${n#.}"
        # echo "$filepathnodot"

        justpathnofile=${n%/*}
        # echo "$justpathnofile"

        if [[ ! "$n" == *"$STRING_TO_ADD_IF_NOT_PRESENT"* ]]; 
        then
            test -e "$n" &&
                newfilename="$n $STRING_TO_ADD_IF_NOT_PRESENT"
                mv -v "$n" "$newfilename"
        fi
    done < <(find . \( -type d -name "[!.]*" \) -print0)
}

rename_folders_dirs_add_new_tags

################################
################################
################################

rename_files_and_folders_dirs_1 () {
    while IFS= read -r -d '' n; do
        if [[ -f $n ]];
        then
            # echo "FILE <<< $n"
            rename_files_remove_old_tags_arguments "$n"
            # rename_files_add_new_tags "$n"
        elif [[ -d "$n" ]];
        then
            echo "DIR >>> $n"
            # rename_folders_dirs_remove_old_tags "$n"
            # rename_folders_dirs_add_new_tags "$n"
        fi
    done < <(find . \( -name "[!.]*" \) -print0)
}

# rename_files_and_folders_dirs_1

################################
################################
################################
