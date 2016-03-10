#!/bin/bash
class="204112"
#assignments names, due date, section and file formats are read from the spreadsheet
#only need one sheet for one course
hourlyScript="TRUE"

spreadsheetKey="1oT_IUOzRPEFR0I3QNXjvpMATFEwFzk9zlqppq7xVrus"

#Then OK or LATE are marked to the following spreadsheet

#declare gsheet_Sec001='0AvEPxHyPxVotdHYzb3JKaFg4VkRKU01VWmp3VUl5T0E'	#pilot
#declare gsheet_Sec002='0AvEPxHyPxVotdE5UWnU5NVEwSkUwWWdGendxMlFIa1E' 	#pilot
#declare gsheet_Sec003='0AvEPxHyPxVotdE5IY0NvMGNySWdJSERZX1NFTzRrWlE'	#pilot

declare gsheet_Sec001='0AvEPxHyPxVotdHV5RVltd3JubjZnT2pZT1VHczl0YUE'	#real
declare gsheet_Sec002='0AvEPxHyPxVotdE1VTDZxT0Z6Z1NtclVpVlZvNGlJQVE'	#real
declare gsheet_Sec003='0AvEPxHyPxVotdGpZa0dVSXBDTlF1WDVCNThDREZJNEE'	#real

#then run these script

workingDir=~kittipitch/private_scripts/
mainScriptDir=~kittipitch/scripts/

. ~kittipitch/scripts/runHWScriptMain.sh


