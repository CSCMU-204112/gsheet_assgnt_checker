#!/bin/bash
pythonDIR="$mainScriptDir"gfill/bin/
#sec="Sec701"
#fileGlob="5*.zip"
#assgn="lab01"
#hwdirMain="$HOME/homework/"
#class="204100"
#duedate="20130618"
#acceptTill="20130621"
#emailAdd="whatever@nowhere.com"
#ftpHost="hw.cs.science.cmu.ac.th"
#ftpUser="hw204100"
#ftpPasswd="cs204100hw"

#echo $sec
#echo $fileGlob
#echo "main Dir = $hwDirMain"

textFill="OK"

#this is string comparing
#will not do anything if the late acceptance date has passed
echo "acceptUntil |"$acceptUnTil"|"
 
if [ $yesterday -gt $duedate ] 
then
    echo "yesterday > duedate"
fi

if [ $yesterday -gt $acceptUnTil ]
then
    echo "After the LATE period"
fi

#ftp the thing to local dir

if [ ! -d $hwdirMain ]; then
#   echo making "hwDirMain"
    mkdir $hwdirMain
fi

hwdir=$hwdirMain$class


if [ ! -d $hwdir ]; then
    mkdir $hwdir
fi

cd $hwdir
#pwd
#ncftpget -R -T -p $ftpPasswd ftp://$ftpUser:@$ftpHost/$sec

outFile=$yesterday"_"$sec$assgn".txt"
#save the file listing from yesterday
if [ ! -f $sec$assgn"_today.txt" ] 
then
    touch $sec$assgn"_today.txt"
fi

mv $sec$assgn"_today.txt" $sec$assgn"_yesterday.txt"


#list the file today w/ time stamp
ls -al --time-style=+'%Y%m%d %H:%M' $sec/*/$fileGlob | sed "s/^ *//;s/ *$//;s/ \{1,\}/ /g" | cut -d' ' -f6-9 > $hwdir/$sec$assgn"_today.txt"

if [[ $active -eq 2 ]]
then
    rm $sec$assgn"_yesterday.txt"
    touch $sec$assgn"_yesterday.txt"
fi
diff $sec$assgn"_today.txt" $sec$assgn"_yesterday.txt" | grep "<" > $sec$assgn"_diff.txt"

# START prepare file to fill the gsheet
secString=$sec"/"

echo $yesterday > $outFile
echo $class$classSuffix >> $outFile
varname=gsheet_$sec
echo $credential >> $outFile
echo "${!varname}" >> $outFile
echo "$sheet_num" "$start_fill_row" >> $outFile
echo $sec >> $outFile

if [[ ($active -eq 2) || ($yesterday -eq $acceptUnTil) ]];
then
    echo $assgn "RECHECK" >> $outFile
else
    echo $assgn "REGULAR" >> $outFile
fi

awkArg="{gsub(\""$secString"\", \"\");print}"
#echo $awkArg
#cat $sec$assgn"_diff.txt" | awk  "$awkArg" | awk -F"\/" '{print $2}' >> $outFile

while read line;
do
    file_name=$(echo $line | awk  "$awkArg" | awk -F"/" '{print $2}')
    handin_date=$(echo $line | awk -F" " '{print $2}')

    if [[ $handin_date -gt $acceptUnTil ]];
    then
        textFillEach="!!!!"
    elif [[ $handin_date -gt $duedate ]];
    then
        textFillEach="LATE"
    else
        textFillEach="  OK"
    fi

    echo -e "$file_name" "$textFillEach" "$handin_date" >> "$outFile"

done < $sec$assgn"_diff.txt"
echo "output file done for $sec - $assgn"
# END prepare file to fill the gsheet
# cat "$outFile"


# if yesterday was the due date, email the whole time stamp
if [ $yesterday == $duedate ]  
then
    echo "yesterday was the due date"
    if [[ (($emailAdd != "")  && (-e /usr/bin/mail)) || ($active -eq 2) ]];
    then
        cat $sec$assgn"_today.txt" | mail -s $class:$sec$assgn": timestamp on duedate" -a "$outFile" $emailAdd
    fi
    #now we fill up the gsheet
    if [ -s $sec$assgn"_diff.txt" ]
    then
        #"$pythonDIR"python3  "$mainScriptDir"fillGSheet3.py < "$outFile" >> "$logFile"
        "$pythonDIR"python3  "$mainScriptDir"fillGSheet3.py < "$outFile" | tee -a "$logFile"
    fi
else
# if due date not passed yet, or handing in late, mail just the diff b/w today and yesterday only if there is a change
    if [ -s $sec$assgn"_diff.txt" ] 
    then
        echo "Changes detected, mailing out changes"


        #now we fill up the gsheet
        if [ $yesterday -gt $acceptUnTil ]
        then
            # will  fill out the spreadsheet in this case and will send mail    
            #cat $sec$assgn"_diff.txt" | mail -s $class:$sec$assgn": past due date" $emailAdd   
            if [[ ($emailAdd != "")  && (-e /usr/bin/mail) ]];
            then
                cat $sec$assgn"_diff.txt" | mail -s $class:$sec$assgn": past due date" -a "$outFile" -r "$sender" $emailAdd
            fi
            #comment out this line below to disable automatic spreadsheet filling (will be filled with !!!!)
            #"$pythonDIR"python3 "$mainScriptDir"fillGSheet3.py < "$outFile" >> "$logFile"
            "$pythonDIR"python3 "$mainScriptDir"fillGSheet3.py < "$outFile" | tee -a "$logFile"
        else
            if [[ ($emailAdd != "")  && (-e /usr/bin/mail) ]];
            then
                cat $sec$assgn"_diff.txt" | mail -s $class:$sec$assgn": timestamp diff" -a "$outFile" -r "$sender" $emailAdd
            fi
            #"$pythonDIR"python3  "$mainScriptDir"fillGSheet3.py < "$outFile" >> "$logFile"
            "$pythonDIR"python3  "$mainScriptDir"fillGSheet3.py < "$outFile" | tee -a "$logFile"
        fi
    else
        echo "Nothing changed"
    fi
fi


rm $outFile

