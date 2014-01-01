#!/bin/bash

Usage="Usage: $0 [-epuI] [-f filename| URL]"
#echo $Usage

mode=url
email=0
phone=0
url=0
IP=0

#if there is no argument, print the Usage
if [[ $# -eq 0 ]]
then
	echo $Usage
	exit 1
#if not, process the arguments, process the arguments one by one
else
	while [[ $1 != "" ]]
	do
		case $1 in
			-f | --file ) 			shift
													if [[ -z $1 ]]
													then 
														echo $Usage
														exit 1
													else
														filename=$1
														mode=file
                  	      fi;;
			-e | --email)       email=$((email+1));;
    	-p | --phone)       phone=$((phone+1));;
      -u | --url  )       url=$((url+1));;
			-I | --IP   )				IP=$((IP+1));;
     		         *)       URL=$1;;
		esac
    shift
	done
fi

#append the argument if it is not empty
forward_to_email(){
	if [[ $1 != "" ]]
	then
		echo "$1" >> ~/proj2/emails.txt
	fi
}

#append the argument if it is not empty
forward_to_phone(){
	if [[ $1 != "" ]]
	then
		echo "$1" >> ~/proj2/phonenumbers.txt
	fi
}

#append the argument if it is not empty
forward_to_url(){
	if [[ $1 != "" ]]
	then
		echo "$1" >> ~/proj2/url.txt
	fi
}
#append the argument if it is not empty
forward_to_IP(){
	if [[ $1 != "" ]]
	then
		echo "$1" >> ~/proj2/IP.txt
	fi
}

get() {
	#scrape for the information using regex and store into the following variables
	get_email=$(echo $1 | grep -E -o -i '[a-z0-9.]+@[a-z0-9]+\.[a-z.]{2,5}') 
	get_phone=$(echo $1 | grep -E -o -i '(\([0-9]{3}\)|[0-9]{3}\-)[0-9]{3}\-[0-9]{4}')
	get_url=$(echo $1 | grep -E -o -i '((https?|ftp)\:\/\/)([0-9a-z\.-]+)\.([a-z\.]{2,6})([/\w\.-]*)*\/?')
	get_IP=$(echo $1 | grep -E -o -i '(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)')
	if [[ $email = 0 ]] && [[ $phone = 0 ]] && [[ $url = 0 ]] && [[ $IP = 0 ]]
	then
		forward_to_email "$get_email"
		forward_to_phone "$get_phone"
		forward_to_url "$get_url"
		forward_to_IP "$get_IP"
	else 
		#if optional arguments are given
		if [[ $email = 1 ]]; then forward_to_email "$get_email"; fi
		if [[ $phone = 1 ]]; then forward_to_phone "$get_phone"; fi
		if [[ $url = 1 ]]; then forward_to_url "$get_url"; fi
		if [[ $IP = 1 ]]; then forward_to_IP "$get_IP"; fi
	fi
}

#the main function
case $mode in
	url)  wget -q -O- "$URL" > ~/proj2/cache
				web=$(cat ~/proj2/cache)
				get "$web"
				;;
  file) file=$(cat "$filename") 
				get "$file"
				;;
esac



