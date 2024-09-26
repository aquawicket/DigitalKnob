#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_callDKBatch(func) args
#
#
dk_callDKBatch() {
	dk_debugFunc 1 99
	
	#dk_validate CMD_EXE "??"
	dk_validate DKBATCH_FUNCTIONS_DIR "dk_validateBranch"
	export DKBATCH_FUNCTIONS_DIR="C:/Users/Administrator/digitalknob/Development/DKBatch/functions"
	export DKBATCH_FUNCTIONS_DIR_="C:/Users/Administrator/digitalknob/Development/DKBatch/functions/"
	
	#dk_debug "cmd.exe /c '(set "DKBATCH_FUNCTIONS_DIR=${DKBATCH_FUNCTIONS_DIR}' && call '${DKBATCH_FUNCTIONS_DIR}/dk_getDefaultGateway.cmd' output_variable)
	
	cmd.exe /c "(set "DKSCRIPT_PATH=${DKSCRIPT_PATH}"&& set "DKBATCH_FUNCTIONS_DIR_=${DKBATCH_FUNCTIONS_DIR_}"&& call ${DKBATCH_FUNCTIONS_DIR}/dk_test.cmd)"
	#cmd.exe /c "set "DKBATCH_FUNCTIONS_DIR_=${DKBATCH_FUNCTIONS_DIR_}" && echo ${DKBATCH_FUNCTIONS_DIR_}"
	#cmd.exe /c "set "DKBATCH_FUNCTIONS_DIR_=${DKBATCH_FUNCTIONS_DIR_}" && call ${DKBATCH_FUNCTIONS_DIR_}dk_test.cmd"
	#cmd.exe /c "(set "DKBATCH_FUNCTIONS_DIR=${DKBATCH_FUNCTIONS_DIR}" ^&^& set "DKBATCH_FUNCTIONS_DIR_=${DKBATCH_FUNCTIONS_DIR_}" ^&^& call "${DKBATCH_FUNCTIONS_DIR}/dk_test.cmd")"
	
	
	#dk_debug "output_variable = ${output_variable-}"
	#$2="${output_variable-}"
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_callDKBatch "dk_test"
}
