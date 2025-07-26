#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_callDKPowershell(func, args)
#
#
dk_callDKPowershell() {
	dk_debugFunc 2
	
    ### get required variables ###
    ### get ALL_BUT_FIRST_ARGS ###
    ### get LAST_ARG ###
    ### Call DKPowershell function ###
    ### process the return value ###
    
    
	math(EXPR ARGC_LAST "${ARGC}-1"
	ARGV_LAST=${ARGV${ARGC_LAST}} 
	dk_debug "ARGV_LAST = ${ARGV_LAST}" 
	
	find_program POWERSHELL_EXE powershell.exe 
	dk_validate DKPOWERSHELL_FUNCTIONS_DIR "dk_DKBRANCH_DIR" 
	set ALL_BUT_FIRST_ARGS ${ARGN}
	execute_process(COMMAND "${POWERSHELL_EXE}" -Command . '${DKPOWERSHELL_FUNCTIONS_DIR}/${func}.ps1'; ${func} ${ARGN} WORKING_DIRECTORY "${DKPOWERSHELL_FUNCTIONS_DIR}" OUTPUT_VARIABLE output_variable)
	dk_debug "output_variable = ${output_variable}"
	#if "${ARGV_LAST}" EQUAL "rtn_var"
		dk_debug "returning ARGV_LAST = ${ARGV_LAST}"
		${rtn_var}="${output_variable}"
	#endif()
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_callDKPowershell dk_messageBox "Testing dk_messageBox" rtn_var
	dk_debug "rtn_var = ${rtn_var}"
}
