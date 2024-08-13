if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_fileAppend){ $dk_fileAppend = 1 } else{ return }

##################################################################################
# dk_fileAppend(filepath, str)
#
#
function Global:dk_fileAppend($filepath, $str) {
	dk_debugFunc 2
	
	if(dk_call dk_pathExists "$filepath"){ echo "$str" >> "$filepath" }
	else{ echo "$str" > "$filepath" }
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_fileAppend "dk_fileAppend_TEST.txt" "string appended from dk_fileAppend"
}