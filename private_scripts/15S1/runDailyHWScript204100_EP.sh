#!/bin/bash
class="204100_EP"
#assignments names, due date, section and file formats are read from the spreadsheet
#only need one sheet for one course
sender="Do Not Reply <server.cscmu@gmail.com>"
spreadsheetKey="1DqbXd4iFYQ4G4z8R2k0NZ3UDKvs1usmR4FOR81EeLCM"

#Then OK or LATE are marked to the following spreadsheet

declare gsheet_Sec701='1TfUU862pygD4PQH43RMMwSo-wGPinpO2-AoxOWXZsag' 	#real

#then run these script

workingDir=~kittipitch/private_scripts/
mainScriptDir=~kittipitch/scripts/

. ~kittipitch/scripts/runHWScriptMain.sh


