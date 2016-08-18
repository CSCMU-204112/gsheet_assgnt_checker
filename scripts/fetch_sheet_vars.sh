#!/usr/bin/env bash
# @Author: kk
# @Date:   2015-12-17 16:16:38 
# @Last Modified by:   Kitt K
# @Last Modified time: 2016-03-10 22:48:23


if [[ ! -d "$hwdirMain" ]]; 
then
    echo making "hwDirMain"
    mkdir "$hwdirMain"
    chmod +rwx "$hwdirMain"
fi

mainTxtFileName=$hwdirMain"main_csv_"$class".tsv"
mainSheetURL="https://docs.google.com/spreadsheet/ccc?key="$main_sheet_key
wget  --quiet --no-check-certificate --output-document="$mainTxtFileName" $mainSheetURL"&output=txt"
echo "" >> $mainTxtFileName
dos2unix $mainTxtFileName
lineCount=0
secCount=0
while read line;
do

    if [[ $lineCount -ne 0 ]];
    then
        active=`echo "$line" | awk -F"\t" '{print $1}'`
        if [[ $active -ne 0 ]]
        then
            sheetType=`echo "$line" | awk -F"\t" '{ print $2}'`
            courseID=`echo "$line" | awk -F"\t" '{ print $3}'`
            secID=`echo "$line" | awk -F"\t" '{ print $4}'`
            sheetID=`echo "$line" | awk -F"\t" '{ print $5}'`
            if [[ "$courseID" == "$class" ]];
            then
                if [[ "$sheetType" == "DEADLINE" ]]
                then
                    echo "D" $sheetType $sheetID
                    deadline_sheet_key="$sheetID"
                    gid=`echo "$line" | awk -F"\t" '{ print $6}'`
                else
                    echo "C" $sheetType $sheetID $secID
                    declare gsheet_Sec"$secID"="$sheetID"
                    start_fill_row=`echo "$line" | awk -F"\t" '{ print $6}'`                    
                    ((secCount++))
                fi
            fi
        fi
    fi
    ((lineCount++))
done < "$mainTxtFileName"
rm "$mainTxtFileName"


