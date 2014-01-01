#!/bin/bash

#check input
if [[ -z "$1" ]] || [[ -z "$2" ]] 
then 
	echo "Please type in a file path and a number of minutes"
	exit 2

#if inputs are valid
elif [[ -e "$1" ]] && [ "$2" -eq "$2" ] 2>/dev/null 
then 
	last_access=$(stat -c %X "$1")
  now=$(date +%s)
  sec_in_min=60

	#check if time since last access in within the bound
  if [[ "$(( $now - $last_access ))" -le "$(( $2 * $sec_in_min ))" ]]
	then
		exit 0
  else exit 1
  fi

#if inputs are not valid
else 
	echo "Invalid file path or time input"
  exit 2
fi
