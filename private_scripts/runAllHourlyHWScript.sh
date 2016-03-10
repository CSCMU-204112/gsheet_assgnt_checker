#!/usr/bin/env bash
hourlyScript="TRUE"
workingDir="../private_scripts/"
workingDir=`realpath $workingDir`"/"


. "$workingDir"runAllDailyHWScript.sh "$class"

