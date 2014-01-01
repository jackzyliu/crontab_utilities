Crontab_Utilities
Created on Oct 30, 2013 by Zheyuan Liu

This directory includes 2 crontab utilities, one for cleaning up the ~/Downloads directory and one for "notification upon reboot about some weather information". In addition, included is also a scraper script.

NOTE: PLease relocate all the files in this directory to "~/crontab_utilities/" as this is the default pathname for all the scripts, subscripts, etc.

1. scraper.sh USAGE: ./scraper.sh [-epui] [-f filename | URL]
	 scraper.sh essentially takes either a URL or a filename and scrape for the specified information. By default, it searches for email addresses, American phone numbers, URLs, and IP addresses. It outputs the results into emails.txt, phonenumbers.txt, urls.txt, and IPs.txt. "-f" takes a valid filename and asks the scraper tolook up a file instead of a URL. scraper.sh takes optional parameters:"-e", "-p", "-u", "-i". 
	 [OPTIONS]
		-e | --email 
				specifies the search targets as email addresses. 
		-p | --phone
				specifies the search targets as phone numbers. 
		-u | --url
				specifies the search targets as URL addresses. 
		-i | --IP
				specifies the search targets as IP addresses.
		The arguments can come in any order, and the result will not be altered.The optional arguments essentially turns off the default output mode and sepecifies the targeted information for scraper.sh.

2. Below is a chart that explains that each space stands for in crontab.
	 * * * * *
	 | | | | |       
   | | | | ---day of week 
   | | | ---month 
   | | ---day of month (1-31)
   | ---hour (0-23)
   ---minute (0-59)
 

3. accessed_in.sh Usage: accesed_in.sh [file path] [num of minutes]
		This shell script returns statuscode 0 if the file specified has not been accessed in the given time period, 1 if it has, and 2 if it receives invalid args. 
		This shell script is a helper script used by list_unused_files.sh.

4. list_unused_files.sh Usage: list_unused_files.sh [num of minutes]
		This shell script lists all the files in ~/Downloads directory that has not been accessed in the give time period. Note: to prevent the files from being listed, simply prepend a "_" to the filename. 
		This shell script is a helper script used by deletion_warning.sh and delete_unused_files.sh

5. deletion_warning.sh Usage: deletion_warning.sh [num of minutes]
		This shell script turns the list of unused files to a pop-up notification, which only happens if the ~/Downloads directory is not empty (that is it only contains filenames starting with "_")

6. delete_unused_files.sh Usage: delete_unused_files.sh [num of minutes]
		This shell script deletes all the files listed by "list_unused_files.sh [num of minutes]".

	
7. boot_notification.sh Usage: boot_notification.sh [city,country]
		The notification contains information such as the current date, day of week, time, and weather. To acquire information about weather, I used API provided by openweathermap.org. To process the Json file, I downloaded the "jq" file in my project directory. The notification script is stored in boot_notification.sh, which takes the current location as an argument. The argument is case-sensitive needs to be in a certain format because it is used the retrieve information from the API. For example, philadelphia should be "Philadelphia,us". To test the funcationality, please type in "./boot_notification.sh Philadelphia,us" in the directory. 
				
