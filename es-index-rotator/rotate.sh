#!/bin/bash
#--------------------------------------------------
# Rotate the indices in elastic of the EFK deployment
#
# @author:  gjmzj
# @usage:   ./rotator.sh <max_days_of_log> [<index_prefix1> ...] 
# @repo:    https://github.com/kubeasz/mirrorepo/es-index-rotator
# @ref:     https://github.com/easzlab/kubeasz/tree/master/manifests/efk/es-index-rotator/rotator.yaml

set -o nounset
set -o errexit
#set -o xtrace

[[ "$#" -gt 1 && $1 =~ ^[1-9][0-9]{0,2}$ ]] || \
{ echo 'Usage: ./rotator.sh <max_days_of_log> [<index_prefix1> <index_prefix2> ...]'; exit 1; }

max_days_of_log="$1"

echo -e "\n[INFO] rotate job starts, try to keep $max_days_of_log days of logs."

curl -s elasticsearch-logging:9200/_cat/indices > /tmp/indices || \
{ echo "[ERROR] Can not connect to elastic!"; exit 1; }

for index_prefix in "${@:2}";do
	cat /tmp/indices|grep "$index_prefix"|wc -l > /tmp/lines
	curr_days_of_log=$(cat /tmp/lines)
	curr_days_of_log=$((${curr_days_of_log}-2))

	if [[ "$max_days_of_log" -gt "$curr_days_of_log" ]];then
    	echo "[WARN] No need to rotate the ES indices: $index_prefix-*!"
	else
   	first_day=$(date -d "$max_days_of_log days ago" +'%Y.%m.%d')
		cat /tmp/indices|grep "$index_prefix"|cut -d' ' -f3|sed "s/$index_prefix-//g"|sed "s/-/\./g" > /tmp/index
    	rotate=$(cat /tmp/index|sort|sed -n "1,/$first_day/"p)
    	for day in $rotate;do
        	curl -s -X DELETE "elasticsearch-logging:9200/$index_prefix-$day"
         day=$(echo $day|sed 's/\./-/g')
         curl -s -X DELETE "elasticsearch-logging:9200/$index_prefix-$day"
    	done
   	 echo -e "\n[INFO] Success to rotate the ES indices: $index_prefix-*!"
	fi
done

exit 0
