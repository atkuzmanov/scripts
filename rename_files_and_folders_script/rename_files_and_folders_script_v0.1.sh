#!/bin/bash

set -e

################################
## TODO: wip not working yet
################################

declare -a STRINGS_TO_REPLACE
STRINGS_TO_REPLACE=("tag1" "tag2")
# STRINGS_TO_REPLACE+=("$n")
# for current_string in "${STRINGS_TO_REPLACE[@]}" ;
# do
#     echo $current_string
# done
STRING_TO_ADD_IF_NOT_PRESENT="tag3"

################################

## https://unix.stackexchange.com/questions/139363/recursively-iterate-through-files-in-a-directory
## https://askubuntu.com/questions/266179/how-to-exclude-ignore-hidden-files-and-directories-in-a-wildcard-embedded-find
## https://stackoverflow.com/questions/229551/how-to-check-if-a-string-contains-a-substring-in-bash
## https://superuser.com/questions/701805/nix-find-type-flag-can-it-accept-multiple-types
## https://stackoverflow.com/questions/15012631/rename-files-and-directories-recursively-under-ubuntu-bash
## https://superuser.com/questions/213134/recursively-rename-files-change-extension-in-linux
## https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash

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
## v0.1 deprecated
# rename_files_and_folders() {
#     while IFS= read -r -d '' n; do
#         if [[ "$n" == *"alk19890105"* ]]; 
#         then
#             echo "Skipping $n"
#         else
#             for current_string in "${STRINGS_TO_REPLACE[@]}" ;
#             do
#                 if [[ "$n" == *"$current_string"* ]]; 
#                 then
#                     echo $n
#                 fi
#             done
#         fi
#         # echo "$n"
#     done < <(find . \( -type d -path '*/\.*' -prune -o -not -name '.*' \) -print0)    
# }
# rename_files_and_folders

################################

# test_f1() {
#     echo "test"
#     ## done < <(find . \( ! -regex '.*/\..*' ! -iname ".*" -type d -o -type f \) -print0)
#     ## done < <(find . \( -type d -path '*/\.*' -prune -o -not -name '.*' \) -print0)
# }
# # test_f1

################################
    
## maybe use this if recursive is not needed
## or use find and add mindepth and maxdepth
# for f in * ;
# do
    # test -f "$n" || echo "$n is not a file."
    # test -d "$n" || echo "$n is not a directory."
# done

################################
################################
################################
