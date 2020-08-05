#!/bin/bash

# clear

set -e

################################

URL="$1"
DOMAIN=""
DOMAIN_STRIPPED=""

################################

extract_domain_name() {
    DOMAIN=$(sed -E -e 's_.*://([^/@]*@)?([^/:]+).*_\2_' <<< "$URL")
}

extract_domain_name

################################

strip_www_from_domain_name() {
    DOMAIN_STRIPPED=$(echo "$DOMAIN" | sed "s/^www\.//")
}

strip_www_from_domain_name

################################

# echo ${URL}
# echo ${DOMAIN}
# echo ${DOMAIN_STRIPPED}

################################

download_entire_website_wget() {
    wget \
    --page-requisites \
    --span-hosts \
    --convert-links \
    --adjust-extension \
    --no-parent \
    --execute robots=off \
    --random-wait \
    --user-agent=Mozilla \
    --continue \
    --no-clobber \
    --directory-prefix="$HOME/Downloads/downloaded-websites-wget/$DOMAIN" \
    --domains ${DOMAIN_STRIPPED} \
    ${URL}
}

download_entire_website_wget

################################
## 
## References
## https://stackoverflow.com/questions/2497215/how-to-extract-domain-name-from-url
## https://superuser.com/questions/14403/how-can-i-download-an-entire-website
## https://unix.stackexchange.com/questions/428989/allow-full-urls-starting-with-http-https-or-www-in-ping/428990#428990
## https://www.linuxjournal.com/content/downloading-entire-web-site-wget
## https://stackoverflow.com/questions/1078524/how-to-specify-the-location-with-wget
## https://www.gnu.org/software/wget/manual/wget.html#Spanning-Hosts
## https://linux.die.net/man/1/wget
## https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
## https://www.devdungeon.com/content/taking-command-line-arguments-bash
## https://www.lifewire.com/pass-arguments-to-bash-script-2200571
## https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script
## http://linuxcommand.org/lc3_wss0120.php
## 
################################
