#!/bin/bash

set -e

################################
## TODO: wip not working yet
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
                    # test -e "$justfilenamenopath" &&
                        # echo "Will rename $justfilenamenopath"
                        # rename -d "$current_string" "$n"

                    newfilename=$(echo "$justfilenamenopath" | sed "s/$current_string//g")
                    # echo "$newfilename"
                    # echo "$filepathnodot --> $justpathnofile$newfilename"
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
