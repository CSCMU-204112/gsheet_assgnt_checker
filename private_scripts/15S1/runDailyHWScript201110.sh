#!/bin/bash
class="201110"
#assignments names, due date, section and file formats are read from the spreadsheet
#only need one sheet for one course
sender="Do Not Reply <server.cscmu@gmail.com>"
spreadsheetKey="1TZ4JTuAYAR_tvvMx8BRsPq-bqPVMiTJ7Mrhh2xM3L4o"

#Then OK or LATE are marked to the following spreadsheet

declare gsheet_Sec001='1xvuKu8gRwzPHeY3ThWZoRljdrTImviVJgVG2S7M2w6Y' 	#real
declare gsheet_Sec002='1-YgTNxqKlIWRuGRXryVpnhoiuq4CJ-DJKk3duAQ2eYA' 	#real
declare gsheet_Sec003='1XuNRl3y-knQzU5S6DrxUCJMuXacGqlci57w02eoQymg'  	#real
declare gsheet_Sec004='1_qyqlb2MAyFztV8uswo3A-VqMy34bUpmAdCAurLRpWU'  	#real

#then run these script

workingDir=~kittipitch/private_scripts/
mainScriptDir=~kittipitch/scripts/

. ~kittipitch/scripts/runHWScriptMain.sh


