#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_callDKBatch(func) args
#
#
dk_callDKBatch() {
	dk_debugFunc 2 99
	
	#dk_validate CMD_EXE "??"
	dk_validate DKBATCH_FUNCTIONS_DIR "dk_validateBranch()"
	cmd /c call "dk_messageBox.cmd" rtn_var ${ARGN} 
	dk_debug("output_variable = ${output_variable}")
	$2="${output_variable}"
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_callDKBatch dk_messageBox rtn_var "MessageBox Title" "Testing dk_messageBox"
	dk_debug "rtn_var = ${rtn_var}"
}
