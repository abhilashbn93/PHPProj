#!/bin/bash

###Get the Test Issue Key using the JIRA key###
curl -D- -u "$1":"$2" -X GET -H "Content-Type: application/json" "http://52.179.141.170/rest/api/2/issue/$3" > get_test_key.json
sed "0,/\"outwardIssue\"/{s/\"outwardIssue\"/@\"outwardIssue\"/}" get_test_key.json > get_test_key.json_1
cut -d "@" -f2 get_test_key.json_1 > get_test_key.json_2
sed "0,/\"key\"/{s/\"key\"/@\"key\"/}" get_test_key.json_2 > get_test_key.json_3
cut -d "@" -f2 get_test_key.json_3 > get_test_key.json_4
sed "0,/\"key\":\"/{s/\"key\":\"/\"key\":\"@/}" get_test_key.json_4 > get_test_key.json_5
cut -d "@" -f2 get_test_key.json_5 > get_test_key.json_6
TKEY=$(cut -d "\"" -f1 get_test_key.json_6|tail -n 1)
rm -rf get_test_key.json*

###Get the Test Issue ID from the JIRA key###

curl -D- -u "$1":"$2" -X GET -H "Content-Type: application/json" "http://52.179.141.170/rest/api/2/issue/$3" > get_test_id.json
sed "0,/\"key\":\"$TKEY\"/{s/\"key\":\"$TKEY\"/@\"key\":\"$TKEY\"/}" get_test_id.json > get_test_id.json_1
cut -d "@" -f1 get_test_id.json_1 > get_test_id.json_2
#echo $(cat get_test_id.json_2) | rev | sed 's/[^0-9]*//g' | rev
ID=$(echo $(cat get_test_id.json_2)|sed -e 's/.*[^0-9]\([0-9]\+\)[^0-9]*$/\1/')
rm -rf get_test_id.json*

###Get the Test Execution Step ID using the Test Issue ID obtained###

curl -D- -u "$1":"$2" -X GET -H "Content-Type: application/json" "http://52.179.141.170/rest/zapi/latest/execution?issueId=$ID" > get_test_execution_id.json
sed "0,/\"orderId\"/{s/\"orderId\"/@\"orderId\"/}" get_test_execution_id.json > get_test_execution_id.json_1
cut -d "@" -f1 get_test_execution_id.json_1 > get_test_execution_id.json_2
#echo $(cat get_test_execution_id.json_2) | rev | sed 's/[^0-9]*//g' | rev
EXID=$(echo $(cat get_test_execution_id.json_2)|sed -e 's/.*[^0-9]\([0-9]\+\)[^0-9]*$/\1/')
rm -rf get_test_execution_id.json*

###Update the Test Status in Zephyr based on the Test Execution ID obtained###

curl -D- -u "$1":"$2" -X PUT --data '{"status":"2"}' -H "Content-Type: application/json" "http://52.179.141.170/rest/zapi/latest/execution/$EXID/execute"
