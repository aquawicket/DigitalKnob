#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

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
	export DKBATCH_APP="C:/Users/Administrator/digitalknob/Development/DKBatch/functions/${1}.cmd"
	
	#(command -v wslpath) && export DKSCRIPT_PATH_WIN=$(wslpath -m "${DKSCRIPT_PATH}")
	(command -v cygpath) && export DKSCRIPT_PATH_WIN=$(cygpath -w "${DKSCRIPT_PATH}")
	(command -v cygpath) && export DKBATCH_FUNCTIONS_DIR_WIN=$(cygpath -w "${DKBATCH_FUNCTIONS_DIR}")
	(command -v cygpath) && export DKBATCH_FUNCTIONS_DIR_WIN_=$(cygpath -w "${DKBATCH_FUNCTIONS_DIR_}")
	(command -v cygpath) && export DKBATCH_APP_WIN=$(cygpath -w "${DKBATCH_APP}")
	
	#builtin echo "call ${DKBATCH_FUNCTIONS_DIR}/$1.cmd ${@:2}"

	last_arg="${@: -1}"
	if [ "${last_arg}" = "rtn_var" ]; then
	#	rtn_var=$(cmd.exe //c "(set "DKSCRIPT_PATH=${DKSCRIPT_PATH_WIN}"&& set "DKBATCH_FUNCTIONS_DIR_=${DKBATCH_FUNCTIONS_DIR_}"&& call "${DKBATCH_APP}" ${@:2})")
	#	rtn_var="${rtn_var##*$'\n'}"  # get the last line of the variable
	#	echo "rtn_var = ${rtn_var}"
		echo "byoass"
	else

		quoted_last_args="$(printf "%q" "${@:2}")"
		quoted_last_args='"a b c"'
		cmd.exe //V:ON //c echo "set DKSCRIPT_PATH=${DKSCRIPT_PATH_WIN} & set DKBATCH_FUNCTIONS_DIR_=${DKBATCH_FUNCTIONS_DIR_WIN_} & call ${DKBATCH_APP_WIN} ${@:2}"
cmd.exe //V:ON //s //c "(set DKINIT=) & (set DKSCRIPT_PATH=${DKSCRIPT_PATH_WIN}) & (set DKBATCH_FUNCTIONS_DIR_=${DKBATCH_FUNCTIONS_DIR_WIN_}) & call ${DKBATCH_APP_WIN} $(cmd //c echo 'a b c')"
	fi
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	#dk_callDKBatch dk_test "arg1" "arg2" rtn_var
	#dk_callDKBatch dk_getDefaultGateway rtn_var
	dk_callDKBatch dk_debug "test dk_debug"
	
	#echo "rtn_var = ${rtn_var}"
}
