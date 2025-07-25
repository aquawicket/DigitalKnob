#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
##################################################################################


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
	dk_call dk_validate DKBATCH_FUNCTIONS_DIR "dk_call dk_DKBRANCH_DIR"
	#echo "DKBATCH_FUNCTIONS_DIR = ${DKBATCH_FUNCTIONS_DIR}"
	#echo "DKBATCH_FUNCTIONS_DIR_ = ${DKBATCH_FUNCTIONS_DIR_}"
	
	export DKBATCH_FUNCTIONS_DIR="${DKBATCH_FUNCTIONS_DIR}"
	export DKBATCH_FUNCTIONS_DIR_="${DKBATCH_FUNCTIONS_DIR_}"
	export DKBATCH_APP="${DKBATCH_FUNCTIONS_DIR}/${1}.cmd"
	
	#(command -v wslpath) && export DKSCRIPT_PATH_WIN=$(wslpath -m "${DKSCRIPT_PATH}")
	(command -v cygpath) && export DKSCRIPT_PATH_WIN=$(cygpath -w "${DKSCRIPT_PATH}")
	(command -v cygpath) && export DKBATCH_FUNCTIONS_DIR_WIN=$(cygpath -w "${DKBATCH_FUNCTIONS_DIR}")
	(command -v cygpath) && export DKBATCH_FUNCTIONS_DIR_WIN_=$(cygpath -w "${DKBATCH_FUNCTIONS_DIR_}")
	(command -v cygpath) && export DKBATCH_APP_WIN=$(cygpath -w "${DKBATCH_APP}")
	
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
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_callDKBatch dk_test "FROM DKBash" "dk_callDKBatch.sh" rtn_var
    dk_call dk_echo ""
	dk_call dk_echo "rtn_var = ${rtn_var-}"
}
