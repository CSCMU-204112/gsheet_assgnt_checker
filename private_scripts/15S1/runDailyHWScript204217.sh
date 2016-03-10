#!/bin/bash
class="204217"
#assignments names, due date, section and file formats are read from the spreadsheet
#only need one sheet for one course
sender="Do Not Reply <server.cscmu@gmail.com>"
spreadsheetKey="1xeGVybj_Rb83_skS8XKqf21WSX2n1RgwroD-6EeNrhc"

#Then OK or LATE are marked to the following spreadsheet

declare gsheet_Sec001='1sRkaQr51tidPwoID39o93Lrd5935FKXc0_RqSCXioSg' 	#real

#then run these script

workingDir=~kittipitch/private_scripts/
mainScriptDir=~kittipitch/scripts/

. ~kittipitch/scripts/runHWScriptMain.sh


