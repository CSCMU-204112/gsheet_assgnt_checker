#!/usr/bin/env bash
# @Author: kk
# @Date:   2015-12-19 14:54:06 

if [[ "$#" -eq 0 ]];then
    echo "Error: need a course number as an argument"
    exit
fi

class="$1"
#assignments names, due date, section and file formats are read from the spreadsheet
#only need one sheet for one course
sender="Do Not Reply <server.cscmu@gmail.com>"
main_sheet_key="1gp83ev9ofy6FPLnBoN4W1wkrrnR2qyZXzY4Gu9LEZAQ"

hwdirMain="$HOME/homework/"
hwdirMain=`eval echo $hwdirMain`

workingDir="$HOME/gsheet_assgnt_checker/private_scripts/"
workingDir=`eval echo $workingDir`

mainScriptDir="$HOME/gsheet_assgnt_checker/scripts/"
mainScriptDir=`eval echo $mainScriptDir`


credential="$workingDir""../../credential/scoreSheet-36e22a114d57.json"
credential=$(readlink -f "$credential")

echo  $credential
#exit

#Then OK or LATE are marked to the following spreadsheet

. "$mainScriptDir"fetch_sheet_vars.sh

if [[ $secCount -eq 0 ]];
then
    echo "No section listed for $class"
    exit
fi

if [[ $deadline_sheet_key == "" ]];
then
    echo "Empty deadline sheetkey"
    exit
fi
# run the timestamp checker
. "$mainScriptDir"runHWScriptMain.sh


