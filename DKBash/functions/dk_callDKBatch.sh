#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_callDKBatch(func) args
#
#
dk_callDKBatch() {
	dk_debugFunc 1 99
	#builtin echo "all but first = ${@:2}"
	#builtin echo "last argument = ${@: -1}"
	
    
    ### get required variables ###
    ### get ALL_BUT_FIRST_ARGS ###
    ### get LAST_ARG ###
    ### Call DKPowershell function ###
    ### process the return value ###
    
    
	#dk_validate CMD_EXE "??"
	dk_call dk_validate DKBATCH_FUNCTIONS_DIR "dk_DKBRANCH_DIR"
	export DKBATCH_FUNCTIONS_DIR="C:/Users/Administrator/digitalknob/Development/DKBatch/functions"
	export DKBATCH_FUNCTIONS_DIR_="C:/Users/Administrator/digitalknob/Development/DKBatch/functions/"

	export DKSCRIPT_PATH_WIN=$(wslpath -m "${DKSCRIPT_PATH}")
	
	#builtin echo "call ${DKBATCH_FUNCTIONS_DIR}/$1.cmd ${@:2}"

	last_arg="${@: -1}"
	if [ "${last_arg}" = "rtn_var" ]; then
		rtn_var=$(cmd.exe /c "(set "DKSCRIPT_PATH=${DKSCRIPT_PATH_WIN}"&& set "DKBATCH_FUNCTIONS_DIR_=${DKBATCH_FUNCTIONS_DIR_}"&& call "${DKBATCH_FUNCTIONS_DIR}/${1}.cmd" ${@:2})")
		rtn_var="${rtn_var##*$'\n'}"  # get the last line of the variable
		#echo "rtn_var = ${rtn_var}"
	else
		cmd.exe /c "(set "DKSCRIPT_PATH=${DKSCRIPT_PATH_WIN}"&& set "DKBATCH_FUNCTIONS_DIR_=${DKBATCH_FUNCTIONS_DIR_}"&& call "${DKBATCH_FUNCTIONS_DIR}/${1}.cmd" ${@:2})"
	fi
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_callDKBatch dk_test "arg1" "arg2" rtn_var
	#dk_callDKBatch dk_getDefaultGateway rtn_var
	echo "rtn_var = ${rtn_var}"
}
