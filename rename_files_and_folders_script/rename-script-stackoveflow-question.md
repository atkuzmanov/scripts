# rename script stackoverflow question

<https://stackoverflow.com/questions/63296988/recursive-bash-script-to-rename-files-and-folders-with-specific-rules-on-mac-lin>

Recursive bash script to rename files and folders with specific rules on Mac/Linux

Hi Folks,

Hope you are all well!

I am after achieving this relatively simple task, yet I am failing in getting optimal results, so I need your help.

Scenario:

I have the following files and folders (directories) structure:

```text
.
├── nested-test-folder-1
│   ├── nested\ test\ file\ 1.txt
│   ├── nested\ test\ file\ 2\ tag1.txt
│   ├── nested\ test\ file\ 3\ tag3.txt
│   └── nested\ test\ file\ 4\ tag2.txt
├── nested-test-folder-2-tag1
│   ├── nested\ test\ file\ 5.txt
│   ├── nested\ test\ file\ 6\ tag1.txt
│   ├── nested\ test\ file\ 7\ tag3.txt
│   └── nested\ test\ file\ 8\ tag2.txt
├── nested-test-folder-3\ tag3
│   ├── nested\ test\ file\ 10\ tag1.txt
│   ├── nested\ test\ file\ 11\ tag3.txt
│   ├── nested\ test\ file\ 12\ tag2.txt
│   └── nested\ test\ file\ 9.txt
├── test\ file\ 13.txt
├── test\ file\ 14\ tag1.txt
├── test\ file\ 15\ tag3.txt
└── test\ file\ 16\ tag2.txt
```

I am trying to write a recursive bash script to rename both the files and folders accordingly:


**- If file/folder contains "tag1" or "tag2" replace them with the new "tag3".**

**- If file/folder does not contain "tag1" or "tag2" and does not already contain "tag3", then add "tag3" to its name.**

**- "tag3" must be added at the end of the file/folder name, in case of a file it must be added before the file extension.**

**- For the sake of the example all file extensions are ".txt" but in the real case they could be anything, so need to take this in consideration.**

**- The script must ignore hidden files and folder (. and .. etc.), dotfiles (.zshrc etc).**


You can have a quick look at the history of this file in my git to see what I have tried:

https://github.com/atkuzmanov/scripts/blob/master/rename_files_and_folders_script/rename_files_and_folders_script_v0.1.sh

https://github.com/atkuzmanov/scripts/tree/master/rename_files_and_folders_script


To summarise what I have tried so far:

Try 1 - do it all at once:

```sh

#!/bin/bash

set -e

declare -a STRINGS_TO_REPLACE
STRINGS_TO_REPLACE=("tag1" "tag2")
STRING_TO_ADD_IF_NOT_PRESENT="tag3"

rename_files_and_folders() {
    while IFS= read -r -d '' n; do
        for current_string in "${STRINGS_TO_REPLACE[@]}" ;
        do
            if [[ "$n" == *"$current_string"* ]] || ! [[ "$n" =~ .*"$STRING_TO_ADD_IF_NOT_PRESENT".* ]]; 
            then
                rename -d "$current_string" "$n"
                break;
            fi
        done
        # echo "$n"
    done < <(find . \( -depth -type d -path '*/\.*' -prune -o -not -name '.*' \) -print0)
}

rename_files_and_folders

```

The output I was getting led me to believe it is renaming a dir first and then trying to rename the files inside using the old name of the dir, so I tried splitting the rename of files and dirs in separate functions.
I also thought it could be easier to first go around and remove "tag1" and "tag2" from all files and folders and then go around and just add "tag3" everywhere.


Try 2 - try to do files and folders (directories) separately:

```sh
#!/bin/bash

set -e

declare -a STRINGS_TO_REPLACE
STRINGS_TO_REPLACE=("tag1" "tag2")
STRING_TO_ADD_IF_NOT_PRESENT="tag3"

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

rename_folders_and_dirs

```

When running the "Try 2" version I get this output:

```sh
Will rename ./test-data-files-and-folders-1/nested-test-folder-1/nested test file 2 tag1.txt
Will rename ./test-data-files-and-folders-1/nested-test-folder-1/nested test file 4 tag2.txt
Will rename ./test-data-files-and-folders-1/test file 14 tag1.txt
Will rename ./test-data-files-and-folders-1/nested-test-folder-2-tag1/nested test file 8 tag2.txt
Can't rename './test-data-files-and-folders-1/nested-test-folder-2-tag1/nested test file 8 tag2.txt' to './test-data-files-and-folders-1/nested-test-folder-2-/nested test file 8 tag2.txt': No such file or directory
Will rename ./test-data-files-and-folders-1/nested-test-folder-2-tag1/nested test file 5.txt
Can't rename './test-data-files-and-folders-1/nested-test-folder-2-tag1/nested test file 5.txt' to './test-data-files-and-folders-1/nested-test-folder-2-/nested test file 5.txt': No such file or directory
Will rename ./test-data-files-and-folders-1/nested-test-folder-2-tag1/nested test file 6 tag1.txt
Can't rename './test-data-files-and-folders-1/nested-test-folder-2-tag1/nested test file 6 tag1.txt' to './test-data-files-and-folders-1/nested-test-folder-2-/nested test file 6 tag1.txt': No such file or directory
Will rename ./test-data-files-and-folders-1/nested-test-folder-2-tag1/nested test file 7 tag3.txt
Can't rename './test-data-files-and-folders-1/nested-test-folder-2-tag1/nested test file 7 tag3.txt' to './test-data-files-and-folders-1/nested-test-folder-2-/nested test file 7 tag3.txt': No such file or directory
Will rename ./test-data-files-and-folders-1/test file 16 tag2.txt
Will rename ./test-data-files-and-folders-1/nested-test-folder-3 tag3/nested test file 12 tag2.txt
Will rename ./test-data-files-and-folders-1/nested-test-folder-3 tag3/nested test file 10 tag1.txt
```

To me it seems it is renaming a dir first and then trying to rename the files inside using an old reference and I cannot seem to be able to get around that.
Also the filters in the functions in `find` - one only for files and one only for folders do not seem to work for some reason.

Other bits and bobs I have tried:

```sh

## getting just the name of the file
filename="${n##*/}"

## removing the preceding dot
currentfile="${n#.}"

## filtering for just files and not dirs and vice versa
if [[ -f "$n" ]] && [[ ! -d "$n" ]];
then
	# ...
fi

```

Any help and advice is greatly appreciated!

Thank you!

---

## edit 1

Here is a working solution I have come up with so far which needs to be optimised and cleaned up, its rudimentary and I can use optimisation tips:

[Solution 1 - GitHub - WIP](https://github.com/atkuzmanov/scripts/blob/master/rename_files_and_folders_script/rename_files_and_folders_script_v1.0.sh)

```sh
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

```

---
---
---
