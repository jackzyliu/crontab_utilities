#!/bin/bash

#check input
if [[ -z $1 ]] 
then
	echo "Please input a time"
#if input is a number
elif [ $1 -eq $1 ] 2>/dev/null
then
	files=$(~/crontab_utilities/list_unused_files.sh "$1") 
	for file in $files
	do
		path=~/Downloads/$file
		#check if the path is a directory
		if [[ -d "$path" ]] 
    then 
			rm -r "$path"
    else rm "$path"
    fi
  done
else 
	echo "Invalid time input"
fi
