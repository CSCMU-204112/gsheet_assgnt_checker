#!/bin/bash
#class="204100"
#spreadsheetURL="https://docs.google.com/spreadsheet/ccc?key=0AvEPxHyPxVotdGRnQlRVVk1XT1FiYnQyQTlqdkw3aFE"
#workingDir="~/dir"

logFile="$HOME/gsheet.log"
logFile=`eval echo $logFile`

txtFileName=$workingDir"csv_"$class".tsv"


ftpDataFile=$workingDir"ftpData/ftp"$class".sh"
. $ftpDataFile

if [ ! -d $hwdirMain ]; then
#       echo making "hwDirMain"
    mkdir $hwdirMain
    chmod +rwx "$hwdirMain"
fi

hwdir=$hwdirMain$class
#echo "hwDir = $hwdir"

if [ ! -d $hwdir ]; then
    mkdir $hwdir
    chmod +rwx "$hwdir"
fi

cd $hwdir
#pwd
#echo "getting into $hwdir"
echo "getting files from ftp"
#echo "ncftpget -R -T -p $ftpPasswd ftp://$ftpUser:@$ftpHost/"
#ncftpget -R -T -p $ftpPasswd ftp://$ftpUser:@$ftpHost/
#echo wget --quiet  -N -S -r -nH --ftp-password="$ftpPasswd"  --ftp-user="$ftpUser" ftp://"$ftpHost"
#exit
wget --quiet  -N -S -r -nH --ftp-password="$ftpPasswd"  --ftp-user="$ftpUser" ftp://"$ftpHost" > /dev/null 2>&1
#wget  -N -S -r -nH --ftp-password="$ftpPasswd"  --ftp-user="$ftpUser" ftp://"$ftpHost"
echo "FTP done"


#using tab separated (txt) and not csv
inputType="txt"
yesterday=`date -d "-1 days" +%Y%m%d`
echo "getting deadline sheet"
spreadsheetURL="https://docs.google.com/spreadsheet/ccc?key="$deadline_sheet_key"&gid="$gid
wget  --quiet --no-check-certificate --output-document=$txtFileName $spreadsheetURL"&output="$inputType
#echo "wget  --quiet --no-check-certificate --output-document=$txtFileName $spreadsheetURL"&output="$inputType"

# check the last HW first

tail -n+2 "$txtFileName" | grep -v '^$'  > $txtFileName"_TEMP"
tac $txtFileName"_TEMP" > "$txtFileName"
rm $txtFileName"_TEMP"
echo "" >> $txtFileName
lineCount=$(cat $txtFileName | wc -l)
dos2unix $txtFileName

while read line
do
	active=`echo "$line" | awk -F"\t" '{ print $1}'`
	#echo "$line"
	if [[ $active -ne 0 ]]
	then
		sec=`echo "$line" | awk -F"\t" '{ print $2}'`
		fileGlob=`echo "$line" | awk -F"\t" '{ print $3}'`
		assgn=`echo "$line" | awk -F"\t" '{ print $4}'`
		hwdirMain=`echo "$line" | awk -F"\t" '{ print $5}'`
		hwdirMain=`eval echo $hwdirMain`
		duedate=`echo "$line" | awk -F"\t" '{ print $6}'`
		acceptUnTil=`echo "$line" | awk -F"\t" '{ print $7}'`			
		mainScript=`echo "$line" | awk -F"\t" '{ print $8}' | tr -d ' '`
		#see if $mainScript has a path specified
		echo "Processing $assgn of section $sec"
		if [[ "$mainScript" != *\/* ]] 
		then
			#echo "appending main script Dir $sec $assgn"
			mainScript=$mainScriptDir$mainScript
		fi
		mainScript=`eval echo $mainScript`
		emailAdd=`echo "$line" | awk -F"\t" '{ print $9}'`
		hw_sheet_num=`echo "$line" | awk -F"\t" '{ print $10}'`
		sheet_num=0
		if [[ "$hw_sheet_num" != "" ]];
		then
			sheet_num=$hw_sheet_num
		fi
		#echo $mainScript
		if [ \( $yesterday -lt $duedate \) -o \( "$hourlyScript" != "TRUE" \) -o \( "$active" -eq 2 \) ]
		then
			. $ftpDataFile
			. $mainScript
		else
			echo "passed soft duedate"
		fi

	else
		echo "row $lineCount inactive"
	fi
	((lineCount--))
done < $txtFileName 
rm $txtFileName


