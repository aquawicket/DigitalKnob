#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

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
