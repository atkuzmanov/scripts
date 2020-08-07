# rename script notes

> References
>
> <https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion>
>
> <https://stackoverflow.com/questions/15012631/rename-files-and-directories-recursively-under-ubuntu-bash>
>
> <https://superuser.com/questions/213134/recursively-rename-files-change-extension-in-linux>
>
> <https://stackoverflow.com/questions/6509650/extract-directory-from-path>
>X
> <https://stackoverflow.com/questions/6121091/get-file-directory-path-from-file-path/6121114>
>
> <https://stackoverflow.com/questions/13210880/replace-one-substring-for-another-string-in-shell-script>
>
> <https://tldp.org/LDP/abs/html/string-manipulation.html>
>
> <https://stackoverflow.com/questions/16623835/remove-a-fixed-prefix-suffix-from-a-string-in-bash>
>
> <https://unix.stackexchange.com/questions/311758/remove-specific-word-in-variable>
>
> <https://unix.stackexchange.com/questions/56810/adding-text-to-filename-before-extension>
>
> <https://stackoverflow.com/questions/45799657/bash-adding-a-string-to-file-name>
>
> <https://linuxize.com/post/bash-functions/>
>
> <https://bash.cyberciti.biz/guide/Pass_arguments_into_a_function>
>
> <https://stackoverflow.com/questions/6212219/passing-parameters-to-a-bash-function>
>
> <https://linuxacademy.com/blog/linux/conditions-in-bash-scripting-if-statements/>

---
---
---

> References
> <https://stackoverflow.com/questions/15012631/rename-files-and-directories-recursively-under-ubuntu-bash>

Rename files and directories recursively under ubuntu /bash

A solution using `find`:

To rename *files only*:

    find /your/target/path/ -type f -exec rename 's/special/regular/' '{}' \;

To rename *directories only*:

    find /your/target/path/ -type d -execdir rename 's/special/regular/' '{}' \+

To rename both *files and directories*:

    find /your/target/path/ -execdir rename 's/special/regular/' '{}' \+

---
---
---

> References
> <https://superuser.com/questions/213134/recursively-rename-files-change-extension-in-linux>

Recursively rename files (change extension) in Linux

Something like:

    find . -name '*.andnav' -exec sh -c 'mv "$0" "${0%.andnav}.tile"' {} \;


### Explanation

The above starts walking the directory tree starting at the current working directory (`.`). Every time a file name matches the pattern `*.andnav` (e.g., `foo.andnav`) the following command is executed:

    sh -c 'mv "$0" "${0%.andnav}.tile"' foo.andnav

Where `$0` is `foo.andnav` and `${0%.andnav}.tile` replaces the `.andnav` suffix with `.tile` so basically:

    mv foo.andnav foo.tile

===

Figured it out

    find . -name "*.andnav" -exec rename -v 's/\.andnav$/\.tile/i' {} \;
    ./0/0.png.andnav renamed as ./0/0.png.tile
    ./0/1.png.andnav renamed as ./0/1.png.tile
    ./1/0.png.andnav renamed as ./1/0.png.tile
    ./1/1.png.andnav renamed as ./1/1.png.tile

of course remove the -v when actually doing it, or it will waste time displaying all the files

---
---
---



