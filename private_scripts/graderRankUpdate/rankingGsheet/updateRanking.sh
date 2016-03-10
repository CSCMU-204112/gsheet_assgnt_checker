#!/usr/bin/env bash
# @Author: kk
# @Date:   2015-08-31 17:40:54 
# @Last Modified by:   kk
# @Last Modified time: 2015-09-02 00:13:37 

workingDir="/home/kittipitch/private_scripts/graderRankUpdate/rankingGsheet"
#pythonCommand="./updater/Scripts/python"
pythonCommand="$workingDir"/updater/bin/python3

rankingPort="8889"
rankingCSV="$workingDir"/ranking_All.csv
oldRankingCSV=$rankingCSV".old"
pythonScript="$workingDir"/fillRanking.py
outFile="$workingDir"/prefilled.csv

spreadsheetKey="1XdCsVBBgPZgB6J5j5DZ4Bc5AX8eXRNvtXf5eXA0s5-A"
echo "$spreadsheetKey" > "$outFile"

/usr/bin/wget "http://127.0.0.1:"$rankingPort"/overview_ranking/csv" -O "$rankingCSV" -a /home/kittipitch/ranking_update.log
/usr/bin/diff "$rankingCSV" "$oldRankingCSV" | grep '<' | awk -F'< ' '{print $2}' >> "$outFile"


if [[ $(cat $outFile | /usr/bin/wc -l) -gt 1 ]];
then
    "$pythonCommand" "$pythonScript" "$outFile"
else
    echo "nothing changed"
fi

#rm $outFile
mv $rankingCSV $rankingCSV".old"
