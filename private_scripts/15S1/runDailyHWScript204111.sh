#!/bin/bash
class="204111"
#assignments names, due date, section and file formats are read from the spreadsheet
#only need one sheet for one course
sender="Do Not Reply <server.cscmu@gmail.com>"
spreadsheetKey="103yYNjahNlstcvzxEYj8vti-cDJAOLaWXSUM5Mtco_Y"

#Then OK or LATE are marked to the following spreadsheet

declare gsheet_Sec001='1RJfoKRE0C5doRRWH8OQOJrc31tdIJkx95ShHzJwyE1Q' 	#real
declare gsheet_Sec002='1Pv4-BMbu5JeW3rrcIS_iCuKuCrOvJWLpzLaqY0xRySM' 	#real
declare gsheet_Sec003='1uOf2M_aJS5W1p-H1t6dZVLLwseexnKumelkBk43NZOQ'  	#real

#then run these script

workingDir=~/bashScripts/hwserverPilot/private_scripts/
mainScriptDir=~/bashScripts/hwserverPilot/scripts/

. ~/bashScripts/hwserverPilot/scripts/runHWScriptMain.sh


