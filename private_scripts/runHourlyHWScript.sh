#!/usr/bin/env bash
# @Author: kk
# @Date:   2015-12-19 14:54:06 

if [[ "$#" -eq 0 ]];then
    echo "Error: need a course number as an argument"
    exit
fi

class="$1"
hourlyScript="TRUE"
workingDir=`eval echo ../private_scripts/`

. "$workingDir"runDailyHWScript.sh "$class"


