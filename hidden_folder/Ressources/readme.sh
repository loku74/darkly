#!/bin/bash

function get_folder {

	local folder=$1
	local url="http://localhost:8080/.hidden/"

	mkdir /tmp/$folder
	wget -q -O /tmp/${folder}index.html $url$folder

	local link
	for link in $(cat /tmp/${folder}index.html | grep href | cut -d'"' -f2 | grep -v "<" | grep -v "\."); do
		if [ "${link: -1}" == "/" ]; then
			get_folder $folder$link
		else
			wget -q -O /tmp/$folder$link $url$folder$link
			cat /tmp/$folder$link
		fi
	done
}

get_folder ""
