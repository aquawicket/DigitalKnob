if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_callDKBash){ $dk_callDKBash = 1 } else{ return }

##################################################################################
# dk_callDKBatch(func) args
#
#
function Global:dk_callDKBash() {
	dk_debugFunc 2 99
	
	#dk_validate CMD_EXE "??"
	#dk_validate DKBATCH_FUNCTIONS_DIR "dk_DKBRANCH_DIR()"
	#cmd /c call "dk_messageBox.cmd" rtn_var ${ARGN} 
	#dk_debug "output_variable = ${output_variable}"
	#$2="${output_variable}"
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	dk_debugFunc 0
	
	#dk_callDKBash dk_messageBox rtn_var "MessageBox Title" "Testing dk_messageBox"
	#dk_debug "rtn_var = ${rtn_var}"
}
