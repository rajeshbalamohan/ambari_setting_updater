#!/bin/bash
# example: sh tune.sh settings.csv localhost admin admin 8080 benchmarkcluster
csvFile=$1
ambariServer=$2
user=$3
password=$4
port=$5
clusterName=$6
# and read line by line using while read combo
while IFS='^' read -r f1 f2 f3
do	
	echo "Location: $f1, Key: $f2, Value: $f3"
	/var/lib/ambari-server/resources/scripts/configs.sh -u "$user" -p "$password" -port "$port" get "$ambariServer" "$clusterName" "$f1" "$f2"
	/var/lib/ambari-server/resources/scripts/configs.sh -u "$user" -p "$password" -port "$port" set "$ambariServer" "$clusterName" "$f1" "$f2" "$f3"
done < "$csvFile"

# Now restart all services in cluster. Better to restart via UI
#curl -u admin:admin -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo": {"context" :"Stop YARN via REST"}, "Body": {"ServiceInfo": {"state": "INSTALLED"}}}' http://"$ambariServer":"$port"/api/v1/clusters/"$clusterName"/services/YARN
#curl -u admin:admin -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo": {"context" :"Start YARN via REST"}, "Body": {"ServiceInfo": {"state": "STARTED"}}}' http://"$ambariServer":"$port"/api/v1/clusters/"$clusterName"/services/YARN

#curl -u admin:admin -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo": {"context" :"Stop MAPREDUCE2 via REST"}, "Body": {"ServiceInfo": {"state": "INSTALLED"}}}' http://"$ambariServer":"$port"/api/v1/clusters/"$clusterName"/services/MAPREDUCE2
#curl -u admin:admin -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo": {"context" :"Start MAPREDUCE2 via REST"}, "Body": {"ServiceInfo": {"state": "STARTED"}}}' http://"$ambariServer":"$port"/api/v1/clusters/"$clusterName"/services/MAPREDUCE2

#curl -u admin:admin -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo": {"context" :"Stop HIVE via REST"}, "Body": {"ServiceInfo": {"state": "INSTALLED"}}}' http://"$ambariServer":"$port"/api/v1/clusters/"$clusterName"/services/HIVE
#curl -u admin:admin -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo": {"context" :"Start HIVE via REST"}, "Body": {"ServiceInfo": {"state": "STARTED"}}}' http://"$ambariServer":"$port"/api/v1/clusters/"$clusterName"/services/HIVE
