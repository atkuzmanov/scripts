clear

echo ">>>---CURL-Loop-Bash-v5.0]---<<<";

req_count=50
counter=1

while [ true ] ; 
# for (( i=1; i<=$req_count; i++ ))
do
	## UNIX timestamp concatenated with nanoseconds
	# T1=$(date +%s000)

response=`curl -i -s -X GET \
-H "Cache-Control:no-cache" \
-H "Accept:application/json" \
-H "X-Candy-Platform:Desktop" \
-H "X-Candy-Audience:Domestic" \
'[URL]'`
  	
  	## curl -X POST --data-urlencode 'payload=SOME_DATA' \
  	## 	--trace-ascii \
	
	counter=$((counter+1))
	## echo "$counter";

	## echo $response $1 | grep '^HTTP/1'	
	echo "$response"

	# T2=$(date +%s000)
	# T="$(($T2-$T1))"
	# echo "[Request-Time]: ${T}"

	sleep 1s; 
done

echo "<<<---[[Done.]--->>>"

exit 0

