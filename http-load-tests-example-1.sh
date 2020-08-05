#!/bin/bash
# 1. Install curl .curlrc with cert and cacert:
# cert   path_To_Your_certificate.pem:password
# cacert  path_To_Your_ca.pem
# 2. Test it: curl http://google.com
# Usage:
# sh run_test.sh ARG1 ARG2 num_request server_env
 

clear



die () {
    echo >&2 "$@"
    exit 1
}



[ "$#" -eq 4 ] || die "4 arguments (ARG1 ARG2 count server_env) required, $# provided"
echo $1 | grep -E -q '^(ARG1-VALUE1|ARG1-VALUE2)$' || die "First argument ARG1 must be ARG1-VALUE1 or ARG1-VALUE2, $1 provided"
echo $2 | grep -E -q '^(ARG2-VALUE1|ARG2-VALUE2)$' || die "Second argument ARG2 must be ARG2-VALUE1 or ARG2-VALUE2, $2 provided"
echo $3 | grep -E -q '^[0-9]+$' || die "Third argument count must be numeric, $3 provided"
echo $4 | grep -E -q '^(int|test|stage|live)$' || die "Fourth argument server env must be int, test, stage or live, $4 provided"



stats="result.txt"
header_dump="headerDump.txt"
time_stats="time_stats.txt"
output="results.json"
arg1=$1
arg2=$2
req_count=$3
server_env=$4
user_agent="load_test/1.0"
verb="GET"
proxy_server="[PROXY-SERVER]"
proxy_port="[PROXY-PORT]"
host="http://URL.${server_env}.com/"
path="[URL-PATH+QUERY-PARAMETERS]"


# REMOVE PREVIOUS STATS
rm -rf $time_stats
rm -rf $header_dump

# UNIX timestamp concatenated with nanoseconds
T1="$(date +%s)"

#for (( i=1; i<=$req_count; i++ ))
#do
     curl -k -s -w "${host}${path} | $(date +%T) | %{http_code}\t | %{size_download}\\n" -X "$verb" -A "$useragent" -H "Accept: application/json" -H "SOME-HEADER1: ${arg1}" -H "SOME-HEADER2: ${arg2}" "${host}${path}"
      
      httperf --hog --server="${proxy_server}" --port="${proxy_port}"  --uri="${host}${path}" --wsess=10,5,2 --rate 1 --timeout 5 --print-reply --add-header="Accept: application/json\nSOME-HEADER1: ARG1-VALUE1\nSOME-HEADER2: ARG2-VALUE2\nUser-Agent: ${user_agent}\n"
      
      echo "${i} out of ${req_count} request."
##sleep 2
 
#done

T2="$(date +%s)"
T="$(($T2-$T1))"
echo "\n--------- Processed ${req_count} requests in ${T} seconds for env ${server_env}."


echo "Done!"

exit 0

