#!/bin/bash

###Get the Test Issue Key using the JIRA key###
curl -D- -u "$1":"$2" -X GET -H "Content-Type: application/json" "http://52.179.141.170/rest/api/2/issue/$3" > get_test_key.json

n=$[$(grep -o 'outwardIssue' get_test_key.json | wc -l)-1];

declare -a TKEY

for (( i=0; i <= $n; ++i ))
do
    j=$[$i+2]
        sed "s/\"outwardIssue\"/#\"outwardIssue\"/g" get_test_key.json > get_test_key.json_1
        cut -d "#" -f"$j" get_test_key.json_1 > get_test_key.json_"$j"
        sed "0,/\"key\"/{s/\"key\"/@\"key\"/}" get_test_key.json_"$j" > get_test_key.json_"$j"_temp1
        cut -d "@" -f2 get_test_key.json_"$j"_temp1 > get_test_key.json_"$j"_temp2
        sed "0,/\"key\":\"/{s/\"key\":\"/\"key\":\"@/}" get_test_key.json_"$j"_temp2 > get_test_key.json_"$j"_temp3
        cut -d "@" -f2 get_test_key.json_"$j"_temp3 > get_test_key.json_"$j"_temp4
        TKEY[$i]=$(cut -d "\"" -f1 get_test_key.json_"$j"_temp4|tail -n 1)
done

#echo "${TKEY[*]}"

rm -rf get_test_key.json*


###Get the Test Issue ID from the JIRA key###

curl -D- -u "$1":"$2" -X GET -H "Content-Type: application/json" "http://52.179.141.170/rest/api/2/issue/$3" > get_test_id.json

n=$[$(grep -o 'outwardIssue' get_test_id.json | wc -l)-1];

declare -a ID

for (( i=0; i <= $n; ++i ))
do
	j=$[$i+2]
        sed "s/\"outwardIssue\"/#\"outwardIssue\"/g" get_test_id.json > get_test_id.json_1
        cut -d "#" -f"$j" get_test_id.json_1 > get_test_id.json_"$j"
		sed "0,/\"key\":\"${TKEY[$i]}\"/{s/\"key\":\"${TKEY[$i]}\"/@\"key\":\"${TKEY[$i]}\"/}" get_test_id.json_"$j" > get_test_id.json_"$j"_temp1
		cut -d "@" -f1 get_test_id.json_"$j"_temp1 > get_test_id.json_"$j"_temp2
		#ID[$i]=$(echo $(cat get_test_id.json_"$j"_temp2)|sed -e 's/.*[^0-9]\([0-9]\+\)[^0-9]*$/\1/')
		echo $(cat get_test_id.json_"$j"_temp2)|sed -e 's/.*[^0-9]\([0-9]\+\)[^0-9]*$/\1/'
done

rm -rf get_test_id.json*

###Get the Test Execution Step ID using the Test Issue ID obtained###

n="${#ID}"

declare -a EXID

for (( i=0; i < $n; ++i ))
do
	j=$[$i+2]
	curl -D- -u "$1":"$2" -X GET -H "Content-Type: application/json" "http://52.179.141.170/rest/zapi/latest/execution?issueId=${ID[$i]}" > get_test_execution_id.json_"$i"
	sed "0,/\"orderId\"/{s/\"orderId\"/@\"orderId\"/}" get_test_execution_id.json_"$i" > get_test_execution_id.json_"$i"_temp1
	cut -d "@" -f1 get_test_execution_id.json_"$i"_temp1 > get_test_execution_id.json_"$i"_temp2
	EXID[$i]=$(echo $(cat get_test_execution_id.json_"$i"_temp2)|sed -e 's/.*[^0-9]\([0-9]\+\)[^0-9]*$/\1/')
done
//rm -rf get_test_execution_id.json*

echo "${EXID[*]}"
###Update the Test Status in Zephyr based on the Test Execution ID obtained###

curl -D- -u "$1":"$2" -X PUT --data '{"status":"1"}' -H "Content-Type: application/json" "http://52.179.141.170/rest/zapi/latest/execution/$EXID/execute"
