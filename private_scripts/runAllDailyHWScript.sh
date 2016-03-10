#!/usr/bin/env bash
# @Author: kk
# @Date:   2015-12-17 16:16:38 
# @Last Modified by:   kk
# @Last Modified time: 2015-12-17 17:32:58 

workingDir=~/private_scripts/
mainScriptDir=~/scripts/

main_sheet_key="1gp83ev9ofy6FPLnBoN4W1wkrrnR2qyZXzY4Gu9LEZAQ"
mainSheetURL="https://docs.google.com/spreadsheet/ccc?key="$main_sheet_key
mainTxtFileName=$hwdirMain"main_csv_"$class".tsv"

wget  --quiet --no-check-certificate --output-document=$mainTxtFileName $mainSheetURL"&output=txt"
echo "" >> $mainTxtFileName
dos2unix $mainTxtFileName
tail -n+2  $mainTxtFileName | grep -v '^$' | awk -F"\t" '{print $1 "\t" $3}' | sort -u > $mainTxtFileName"_TEMP"
mv  $mainTxtFileName"_TEMP" $mainTxtFileName

lineCount=0
while read line;
do
    active=`echo "$line" | awk -F"\t" '{print $1}'`
    if [[ $active -ne 0 ]]
    then
        courseID=`echo "$line" | awk -F"\t" '{ print $2}'`
	if [[ $hourlyScript == "TRUE" ]];
        then
	    echo "running hourly script on "$courseID
	    "$workingDir"runHourlyHWScript.sh $courseID
        else
	    echo "running daily script on "$courseID
	    "$workingDir"runDailyHWScript.sh $courseID
        fi
    fi
    ((lineCount++))
done < $mainTxtFileName
