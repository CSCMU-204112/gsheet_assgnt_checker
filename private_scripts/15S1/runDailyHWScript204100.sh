#!/bin/bash
class="204100"
#assignments names, due date, section and file formats are read from the spreadsheet
#only need one sheet for one course
sender="Do Not Reply <server.cscmu@gmail.com>"
spreadsheetKey="1-MMKtTZ-NtncXy_7oq055nzbCiIPofDUc4-VdDswygU"

#Then OK or LATE are marked to the following spreadsheet

declare gsheet_Sec001='1DcwLlQ3c11A76GU_lZba9UhfMYXQ6ZtAUQClCzYX0KM' 	#real
declare gsheet_Sec002='1L1etHuo-Yld45RKjB27z5ZhWiHGCKNVMylmQic9Kd6U' 	#real
declare gsheet_Sec003='1oHw4bvLvr4PaFapPELjo6LCBTAS5shAinBsqFw7e51I'
declare gsheet_Sec004='1yegBFkaGHmw0hcH2jZvXwWvCbuHJM-OcLqAJ-OB_EP8'
declare gsheet_Sec007='11sm85ZClf0Y2tpPzdKOgFUdJf3rhPtm0bTFx5NmXkpk'
declare gsheet_Sec008='1IQv7X95eGKp6tnMvyOZAvOwqRKv3rhx5JFHKenFArFs' 	#real
declare gsheet_Sec801='1HREDdzOJ5volb5NUAuotI5s7LQVnL17zqXztZw3h-4I' 	#real
declare gsheet_Sec802='1xsGgdoFlbrxoSkbTEIr6k5of-PMgKPb0xyxC_xE539Q' 	#real
declare gsheet_Sec803='1YpO0obIIuAC-Ywt3jglqzIkfwH_qm5-qLSye8RnqXog'  	#real

#then run these script

workingDir=~kittipitch/private_scripts/
mainScriptDir=~kittipitch/scripts/

. ~kittipitch/scripts/runHWScriptMain.sh


