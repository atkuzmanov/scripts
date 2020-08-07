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
