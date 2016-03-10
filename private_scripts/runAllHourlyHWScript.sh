#!/usr/bin/env bash
hourlyScript="TRUE"
workingDir="$HOME/gsheet_assgnt_checker/private_scripts/"
workingDir=`eval echo $workingDir`


. "$workingDir"runAllDailyHWScript.sh "$class"

