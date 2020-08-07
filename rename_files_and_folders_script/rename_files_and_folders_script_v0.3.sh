#!/bin/bash

set -e

################################

declare -a STRINGS_TO_REPLACE
STRINGS_TO_REPLACE=("tag1" "tag2")
STRING_TO_ADD_IF_NOT_PRESENT="tag3"

################################

rename_files_and_folders() {
    while IFS= read -r -d '' n; do

        # justfilenamenopath="${n##*/}"
        
        filepathnodot="${n#.}"
        # echo "$filepathnodot"

        justfilenamenopath="${n##*/}"
        # echo "$justfilenamenopath"

        justpathnofile=${n%/*}
        # echo "$justpathnofile"


        # if [[ -f "$filepathnodot" ]] && [[ ! -d "$filepathnodot" ]];
        # then

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

        # fi
    done < <(find . \( -type f -name "[!.]*" \) -print0)
}

rename_files_and_folders



################################
################################
################################


################################
################################
################################
