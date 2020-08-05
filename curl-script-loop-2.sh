clear

echo "[CURL-Loop-Bash-v2.1]" ;

counter=1

while [ true ] ; 
do 
	# UNIX timestamp concatenated with nanoseconds
	T1="$(date +%s)"

	curl \
	--insecure \
	--request GET \
	--proxy "[PROXY-SERVER]:[PROXY-PORT]" \
	--url "[URL]" \
	--header "Cache: no-cache" \
	--header "Content-Type: text/plain" \
	--header "Content-Length: 1024" \
	--data-urlencode "cash_buster=$counter" \
	--data-urlencode "cash_buster-2=$counter" \
	--user-agent "[CURL-Loop-Bash-v2.1]" \
	--include \
	--verbose \
	--location \
	--output "/dev/null" \
	--write-out "\\n Response-HTTP-code: %{http_code} | Current-time: $(date "+%H:%M:%S %d-%m-%Y") | Size: %{size_download} | Total-time-to-complete: %{time_total} \\n" 
  	
  	## curl -X POST --data-urlencode 'payload=SOME_DATA' \
  	## 	--trace-ascii \

	T2="$(date +%s)"
	T="$(($T2-$T1))"
	## echo "[Request-Time]: ${T}"
	
	counter=$((counter+1))
	## echo "$counter";

	sleep 1 ; 
done



