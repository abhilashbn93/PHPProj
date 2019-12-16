#!/bin/bash

###Get the Test Execution Step ID using the Test Issue ID obtained###

curl -D- -u "$1":"$2" -X GET -H "Content-Type: application/json" "http://52.179.141.170/rest/zapi/latest/execution?issueId=$3" > get_test_execution_id.json
sed "0,/\"orderId\"/{s/\"orderId\"/@\"orderId\"/}" get_test_execution_id.json > get_test_execution_id.json_1
cut -d "@" -f1 get_test_execution_id.json_1 > get_test_execution_id.json_2
#echo $(cat get_test_execution_id.json_2) | rev | sed 's/[^0-9]*//g' | rev
EXID=$(echo $(cat get_test_execution_id.json_2)|sed -e 's/.*[^0-9]\([0-9]\+\)[^0-9]*$/\1/')
rm -rf get_test_execution_id.json*

###Update the Test Status in Zephyr based on the Test Execution ID obtained###

curl -D- -u "$1":"$2" -X PUT --data '{"status":"2"}' -H "Content-Type: application/json" "http://52.179.141.170/rest/zapi/latest/execution/$EXID/execute"
