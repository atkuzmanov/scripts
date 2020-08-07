#!/bin/bash

set -e

################################

declare -a STRINGS_TO_REPLACE
STRINGS_TO_REPLACE=("tag1" "tag2")
STRING_TO_ADD_IF_NOT_PRESENT="tag3"

################################

rename_files_remove_old_tags() {
    while IFS= read -r -d '' n; do

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

# rename_files_remove_old_tags

################################

rename_dirs_folders_remove_old_tags() {
    while IFS= read -r -d '' n; do

        filepathnodot="${n#.}"
        # echo "$filepathnodot"

        # justfilenamenopath="${n##*/}"
        # echo "$justfilenamenopath"

        # justpathnofile=${n%/*}
        # echo "$justpathnofile"


        # if [[ -f "$filepathnodot" ]] && [[ ! -d "$filepathnodot" ]];
        # then

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

        # fi
    done < <(find . \( -type d -name "[!.]*" \) -print0)
}

rename_dirs_folders_remove_old_tags

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
################################


################################
################################
################################
