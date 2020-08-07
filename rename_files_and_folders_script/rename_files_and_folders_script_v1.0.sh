#!/bin/bash

set -e

################################
## WORKING
## TODO: optimise
## TODO: expand features to take user input
## for example call script with flags for different functions
## passing different arguments such as tags to remove or tags to add
################################

declare -a STRINGS_TO_REPLACE
STRINGS_TO_REPLACE=("tag1" "tag2")

STRING_TO_ADD_IF_NOT_PRESENT="tag3"

################################

rename_files_and_folders_dirs_1 () {
    while IFS= read -r -d '' n; do
        if [[ -f $n ]];
        then
            echo "FILE <<< $n"
            # rename_files_remove_old_tags "$n"
            # rename_files_add_new_tags "$n"
        elif [[ -d "$n" ]];
        then
            echo "DIR >>> $n"
            # rename_folders_dirs_remove_old_tags "$n"
            # rename_folders_dirs_add_new_tags "$n"
        fi
    done < <(find . \( -name "[!.]*" \) -print0)
}

rename_files_and_folders_dirs_1

################################

################################
################################
################################

rename_files_remove_old_tags() {
    # while IFS= read -r -d '' n; do

        filepathnodot="${$1#.}"
        # echo "$filepathnodot"

        justfilenamenopath="${$1##*/}"
        # echo "$justfilenamenopath"

        justpathnofile=${$1%/*}
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
    # done < <(find . \( -type f -name "[!.]*" \) -print0)
}

# rename_files_remove_old_tags

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
                    # echo "$newfilename"
                    mv -v "$n" "$newfilename"
                break;
            fi
        done
    done < <(find . \( -type d -name "[!.]*" \) -print0)
}

# rename_folders_dirs_remove_old_tags

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

# rename_files_add_new_tags

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

# rename_folders_dirs_add_new_tags

################################
################################
################################
