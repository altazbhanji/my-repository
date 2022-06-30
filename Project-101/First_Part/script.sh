#!/bin/bash -x

# usage: "script_name <file_name>"

if [[ "$#" -ne 1 ]]
then
	echo "Usage script_name <file_name>"
	exit 1
fi

FILE=$1

cat $FILE | grep TerminateInstances | grep -i Serdar | grep -Eo "i-[a-z0-9]{17}" | sort | uniq > result.txt
