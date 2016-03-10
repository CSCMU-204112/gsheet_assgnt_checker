#!/usr/bin/env bash
# @Author: kk
# @Date:   2015-12-19 14:54:06 

if [[ "$#" -eq 0 ]];then
    echo "Error: need a course number as an argument"
    exit
fi

class="$1"
hourlyScript="TRUE"

workingDir="$HOME/gsheet_assgnt_checker/private_scripts/"
workingDir=`eval echo $workingDir`

. "$workingDir"runDailyHWScript.sh "$class"


