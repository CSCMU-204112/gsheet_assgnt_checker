#!/usr/bin/env bash
# @Author: kk
logFile="/home/kittipitch/homework/204111/gsheet.log"
class=204111
mainScriptDir="/home/kittipitch/scripts/"
workingDir="/home/kittipitch/temp/"
txtFileName=$workingDir"csv_"$class".tsv"
spreadsheetKey=1dyQTXCP7aty2EWxtPbPea1_uqL_0LCI2g6dzG-fuLUA
sheetID=0
inputType="txt"
spreadsheetURL="https://docs.google.com/spreadsheet/ccc?key="$spreadsheetKey"&gid="$sheetID
wget  --quiet --no-check-certificate --output-document=$txtFileName $spreadsheetURL"&output="$inputType
cat  $txtFileName | while read line
do
    active=`echo "$line" | awk -F"\t" '{ print $1}'`
    if [[ $active -ne 0 ]]
    then
        yesterday=`echo "$line" | awk -F"\t" '{ print $2}'` 
        course=`echo "$line" | awk -F"\t" '{ print $3}'`
        gsheetOut=`echo "$line" | awk -F"\t" '{ print $4}'`
        sec=`echo "$line" | awk -F"\t" '{ print $5}'`
        textFill=`echo "$line" | awk -F"\t" '{ print $6}'`
        assgn=`echo "$line" | awk -F"\t" '{ print $7}'`
        assgnFileName=`echo "$line" | awk -F"\t" '{ print $8}'`

        outFile=$yesterday"_"$sec$assgn".txt"

        echo $yesterday > $outFile
        echo $course >> $outFile
        echo $gsheetOut >> $outFile
        echo $sec >> $outFile
        echo $textFill >> $outFile
        echo $assgn >> $outFile
        echo $assgnFileName >> $outFile
        /usr/local/bin/python3 "$mainScriptDir"fillGSheet3.py < "$outFile" >> "$logFile"
        #/usr/local/bin/python3 "$mainScriptDir"fillGSheet3.py < "$outFile" 
        cat "$outFile"
        rm "$outFile"
    fi
done
rm $txtFileName
