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
        #TKEY[$i]=$(cut -d "\"" -f1 get_test_key.json_"$j"_temp4|tail -n 1)
	echo $(cut -d "\"" -f1 get_test_key.json_"$j"_temp4|tail -n 1) 
done

#echo "${TKEY[*]}"

rm -rf get_test_key.json*
