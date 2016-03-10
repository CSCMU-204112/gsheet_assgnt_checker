#!/bin/bash
class="204217"
#assignments names, due date, section and file formats are read from the spreadsheet
#only need one sheet for one course
spreadsheetURL="https://docs.google.com/spreadsheet/ccc?key=0AvEPxHyPxVotdDM3TzNvV05rZ3JiWnFhcGE1Tk9RNHc"

#Then OK or LATE are marked to the following spreadsheet
# which has to be writable by server.cscmu@gmail.com

declare gsheet_Sec001='1r5wRkS0ZXtcuft-fwpDa7Hd2zujov5o74ZgyWfJoz1k'


#these script will process the rest

workingDir=~kittipitch/private_scripts/
mainScriptDir=~kittipitch/scripts/

. ~kittipitch/scripts/runHWScriptMain.sh


