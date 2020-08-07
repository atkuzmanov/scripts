#!/bin/bash

set -e

################################

declare -a STRINGS_TO_REPLACE
STRINGS_TO_REPLACE=("tag1" "tag2")
STRING_TO_ADD_IF_NOT_PRESENT="tag3"

################################

rename_files_and_folders() {
    while IFS= read -r -d '' n; do

        # filename="${n##*/}"
        # currentfile="${n#.}"

        # if [[ -f "$n" ]] && [[ ! -d "$n" ]];
        # then

            for current_string in "${STRINGS_TO_REPLACE[@]}" ;
            do
                if [[ "$n" == *"$current_string"* ]]; 
                then
                    echo "Will rename $n"
                    test -e "$n" &&
                        rename -d "$current_string" "$n"
                    break;
                fi
            done

        # fi


    done < <(find . \( -type f -name "[!.]*" \) -print0)
}

rename_files_and_folders

rename_folders_and_dirs() {
    while IFS= read -r -d '' n; do


        if [[ -d "$n" ]];
        then

        for current_string in "${STRINGS_TO_REPLACE[@]}" ;
        do
            if [[ "$n" == *"$current_string"* ]]; 
            then
                echo "Will rename $n"
                test -e "$n" &&
                    rename -d "$current_string" "$n"
                break;
            fi
        done

        fi

    done < <(find . \( -depth -name "[!.]*" \) -print0)
}

# rename_folders_and_dirs


################################
################################
################################

## TODO: clean up draft work below

## v0.3 deprecated
# rename_files_and_folders() {
#     while IFS= read -r -d '' n; do
#         for current_string in "${STRINGS_TO_REPLACE[@]}" ;
#         do
#             if [[ "$n" == *"$current_string"* ]] || ! [[ "$n" =~ .*"alk19890105".* ]]; 
#             then
#                 echo "Will rename $n"
#                 break;
#             fi
#         done
#         # echo "$n"
#     done < <(find . \( -depth -type d -path '*/\.*' -prune -o -not -name '.*' \) -print0)
# }
# rename_files_and_folders

# done < <(find . \( -type f -o -type d -name "[!.]*" \) -print0)

################################

## v0.2 deprecated
# rename_files_and_folders() {
#     while IFS= read -r -d '' n; do
#         if [[ "$n" == *"alk19890105"* ]]; 
#         then
#             echo "Skipping $n"
#         elif [[ "$n" =~ .*"alk".* ]]
#         then
#             for current_string in "${STRINGS_TO_REPLACE[@]}" ;
#             do
#                 if [[ "$n" == *"$current_string"* ]]; 
#                 then
#                     echo "Will rename $n"
#                 fi
#             done
#         else
#             echo "Will also rename $n"
#         fi
#         # echo "$n"
#     done < <(find . \( -depth -type d -path '*/\.*' -prune -o -not -name '.*' \) -print0)
# }
# rename_files_and_folders

################################
################################
################################
