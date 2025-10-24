#!/bin/bash

rm $1

if [ $# -ne 1 ]; then
    echo "Usage: $0 output_file"
    exit 1
fi

for folder in $(ls); do
    if [ ! -d $folder ]; then
        continue
    fi
    cat $folder/flag >> $1
done

check=$(cat $1 | sort | uniq | wc -l)

if [ $check -eq 14 ]; then
    echo "Ok!"
else
    echo "Scroutch (y a des flags identiques)"
fi
