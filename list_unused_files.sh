#!/bin/bash
#check input
if [[ -z $1 ]]
then
	echo "Please type in a time"
#if input is a number
elif [ $1 -eq $1 ] 2>/dev/null
then
	files=$(ls ~/Downloads)
	#loop over the filenames
  for file in $files
	do
		#check if a file starts with "_"
		case $file in
		_*) ;;
		* ) #if not, list them
				path=~/Downloads/$file
				#run accessed_in.sh
				~/crontab_utilities/accessed_in.sh "$path" "$1"
				#check statuscode
				if [[ $? -eq 1 ]]
  			then
				echo "$file"
    		fi
				;;
		esac
	done
else
	echo "Invalid time input"
fi
