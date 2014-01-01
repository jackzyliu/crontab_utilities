#!/bin/bash

is_empty(){
files=$(ls -A ~/Downloads/)

bool=0

for file in $files
do 
	case $file in
	_*) ;;
	*) bool=1 ;;
	#indicates that there are files that do not start with "_"
	esac
done

echo $bool
}

bool=$(is_empty)

if [[ $bool = 1 ]]
then
	notify-send -t 5000 "These files wil be deleted in $2 minutes:" "$(~/crontab_utilities/list_unused_files.sh "$1")"
fi
