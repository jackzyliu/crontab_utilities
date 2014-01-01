#!/bin/bash

#This shell script notifies the user the time, day, date, and weather of the current location

get_data(){
#get the weather from openweathermap.org
wget -q -O- "http://api.openweathermap.org/data/2.5/weather?q=$1&&APPID=6187a50c556222207bd00c77e67eaae1" > ~/crontab_utilities/weather_cache

date=$(date +%D)

dow=$(date +%A)

t=$(date +%R)

user=$(whoami)

temp=$(cat ~/crontab_utilities/weather_cache | ~/crontab_utilities/jq '.main.temp')
temp=$(bc -l <<< "$temp - 273.15")

humidity=$(cat ~/crontab_utilities/weather_cache | ~/crontab_utilities/jq '.main.humidity')

sunrise=$(cat ~/crontab_utilities/weather_cache | ~/crontab_utilities/jq '.sys.sunset')
sunrise=$(date +%R -d @$sunrise)

sunset=$(cat ~/crontab_utilities/weather_cache | ~/crontab_utilities/jq '.sys.sunrise')
sunset=$(date +%R -d @$sunset)

notification=("Welcome back, $user!" "Today is $dow, $date." "It is $t right now." "Below is your current weather information" "--Location    : $1" "--Temperature : $temp degree Celsius" "--Humidity    : $humidity%" "--Sunrise     : $sunrise" "--Sunset      : $sunset" " " "Have a nice day!")

ctr=0

while [[ $ctr -le 10 ]]
do
	echo ${notification[$ctr]}
	ctr=$((ctr + 1))
done
}

notify-send -t 5000 "Daily Greeting:" "$(get_data $1)"
