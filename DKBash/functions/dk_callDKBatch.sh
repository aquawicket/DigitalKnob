<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

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
    
<<<<<<< HEAD
    
	#dk_validate CMD_EXE "??"
	dk_call dk_validate DKBATCH_FUNCTIONS_DIR "dk_DKBRANCH_DIR"
	export DKBATCH_FUNCTIONS_DIR="C:/Users/Administrator/digitalknob/Development/DKBatch/functions"
	export DKBATCH_FUNCTIONS_DIR_="C:/Users/Administrator/digitalknob/Development/DKBatch/functions/"
	export DKBATCH_APP="C:/Users/Administrator/digitalknob/Development/DKBatch/functions/${1}.cmd"
=======
	#dk_validate CMD_EXE "??"
	dk_call dk_validate DKBATCH_FUNCTIONS_DIR "dk_call dk_DKBRANCH_DIR"
	#echo "DKBATCH_FUNCTIONS_DIR = ${DKBATCH_FUNCTIONS_DIR}"
	#echo "DKBATCH_FUNCTIONS_DIR_ = ${DKBATCH_FUNCTIONS_DIR_}"
	
	export DKBATCH_FUNCTIONS_DIR="${DKBATCH_FUNCTIONS_DIR}"
	export DKBATCH_FUNCTIONS_DIR_="${DKBATCH_FUNCTIONS_DIR_}"
	export DKBATCH_APP="${DKBATCH_FUNCTIONS_DIR}/${1}.cmd"
>>>>>>> Development
	
	#(command -v wslpath) && export DKSCRIPT_PATH_WIN=$(wslpath -m "${DKSCRIPT_PATH}")
	(command -v cygpath) && export DKSCRIPT_PATH_WIN=$(cygpath -w "${DKSCRIPT_PATH}")
	(command -v cygpath) && export DKBATCH_FUNCTIONS_DIR_WIN=$(cygpath -w "${DKBATCH_FUNCTIONS_DIR}")
	(command -v cygpath) && export DKBATCH_FUNCTIONS_DIR_WIN_=$(cygpath -w "${DKBATCH_FUNCTIONS_DIR_}")
	(command -v cygpath) && export DKBATCH_APP_WIN=$(cygpath -w "${DKBATCH_APP}")
	
<<<<<<< HEAD
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
=======
	dk_call dk_printVar DKSCRIPT_PATH_WIN
	dk_call dk_printVar DKBATCH_FUNCTIONS_DIR_WIN
	dk_call dk_printVar DKBATCH_FUNCTIONS_DIR_WIN_
	dk_call dk_printVar DKBATCH_APP_WIN
	
	CMD_EXE=$(which cmd.exe)
	echo "CMD_EXE = '${CMD_EXE}'"
	echo "DKBATCH_APP_WIN = '${DKBATCH_APP_WIN}'"
	echo "cmnd = ${CMD_EXE} //V:ON //c ${DKBATCH_FUNCTIONS_DIR}/${1}.cmd ${@:2}"
	#export DKINIT=""
	${CMD_EXE} //V:ON //c call ${DKBATCH_APP_WIN} ${@:2}
	#echo "output = ${output}"


#	last_arg="${@: -1}"
#	if [ "${last_arg}" = "rtn_var" ]; then
#		#rtn_var=$(cmd.exe //c "(set "DKSCRIPT_PATH=${DKSCRIPT_PATH_WIN}"&& set "DKBATCH_FUNCTIONS_DIR_=${DKBATCH_FUNCTIONS_DIR_}"&& call "${DKBATCH_APP}" ${@:2})")
#		#rtn_var="${rtn_var##*$'\n'}"  # get the last line of the variable
#		#echo "rtn_var = ${rtn_var}"
#	else
#
#	quoted_last_args="$(printf "%q" "${@:2}")"
#	quoted_last_args='"a b c"'
#
#	echo "$(/c/Windows/System32/cmd.exe ver)"
#	/c/Windows/System32/cmd.exe //V:ON //c echo "set DKSCRIPT_PATH=${DKSCRIPT_PATH_WIN} & set DKBATCH_FUNCTIONS_DIR_=${DKBATCH_FUNCTIONS_DIR_WIN_} & call ${DKBATCH_APP_WIN} ${@:2}"
#
#	fi
>>>>>>> Development
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
<<<<<<< HEAD
	#dk_callDKBatch dk_test "arg1" "arg2" rtn_var
	#dk_callDKBatch dk_getDefaultGateway rtn_var
	dk_callDKBatch dk_debug "test dk_debug"
	
	#echo "rtn_var = ${rtn_var}"
=======
	dk_call dk_callDKBatch dk_test "FROM DKBash" "dk_callDKBatch.sh" rtn_var
    dk_call dk_echo ""
	dk_call dk_echo "rtn_var = ${rtn_var-}"
>>>>>>> Development
}
