#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <md5_hash> <dictionary_file>"
	exit 1
fi

hash=$1
dictionary=$2

for passwd in $(cat ${dictionary}); do

	passwd_hash=$(echo -n $passwd | md5sum | cut -d' ' -f1)

	if [ $hash == $passwd_hash ]; then
		echo "Password found: $passwd"
		break
	fi
done
