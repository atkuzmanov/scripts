
##
# You call it with two params the date and the hour, eg:
# 2016-04-19 13
# That would give you 13-14.00 GMT today

date="$1"
hour="$2"
echo "getting log for $1 $2"
endOfStringWithExt="_00_00.bz2"
endOfString="_00_00"
curlLocation="[CURL_INSTALATION_LOCATION]"
p12Location="[P12_LOCATION]"
p12Pass="[PASSWORD]"

server_list[0]="[SERVER_NAME]"
server_list[1]="[SERVER_NAME]"
server_list[2]="[SERVER_NAME]"
server_list[3]="[SERVER_NAME]"
server_list[4]="[SERVER_NAME]"
server_list[5]="[SERVER_NAME]"
server_list[6]="[SERVER_NAME]"
server_list[7]="[SERVER_NAME]"
server_list[8]="[SERVER_NAME]"
server_list[9]="[SERVER_NAME]"
server_list[10]="[SERVER_NAME]"
server_list[11]="[SERVER_NAME]"
server_list[12]="[SERVER_NAME]"
server_list[13]="[SERVER_NAME]"
server_list[14]="[SERVER_NAME]"
server_list[15]="[SERVER_NAME]"

for i in "${server_list[@]}"
do
    $curlLocation -E $p12Location:$p12Pass -O "URL_WITH_SERVER_NAME_INSERTED_BY_DOLLAR_I-$i-LOG_PATH-$date-$hour$endOfStringWithExt"
    mv access_log-$date-$hour$endOfStringWithExt $i-access_log-$date-$hour$endOfStringWithExt
    bzip2 -d $i-access_log-$date-$hour$endOfStringWithExt
    cat $i-access_log-$date-$hour$endOfString | grep "GET /[PATH]/" >> "log_file.log"
    rm $i-access_log-$date-$hour$endOfString
done
mv log_file.log log_file-$1-$2.log






