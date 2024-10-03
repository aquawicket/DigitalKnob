#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_callDKBatch(func) args
#
#
function(dk_callDKBatch func rtn_var)
	dk_debugFunc("\${ARGV}")
	
	dk_validate(CMD_EXE "dk_depend(cmd)")
    dk_replaceAll("${CMD_EXE}" "/" "\\" CMD_EXE_WIN)
	dk_validate(DKBATCH_FUNCTIONS_DIR "dk_DKBRANCH_DIR()")
    dk_replaceAll("${DKBATCH_FUNCTIONS_DIR}" "/" "\\" DKBATCH_FUNCTIONS_DIR_WIN)
    
           dk_echo("COMMAND '${CMD_EXE_WIN}' /V:ON /c '${DKBATCH_FUNCTIONS_DIR_WIN}\\${func}.cmd' '${ARGN}' WORKING_DIRECTORY '${DKBATCH_FUNCTIONS_DIR}' OUTPUT_VARIABLE rtn_value ECHO_OUTPUT_VARIABLE")
	execute_process(COMMAND "${CMD_EXE_WIN}" /V:ON /c "${DKBATCH_FUNCTIONS_DIR_WIN}\\${func}.cmd" '${ARGN}' WORKING_DIRECTORY "${DKBATCH_FUNCTIONS_DIR}" OUTPUT_VARIABLE rtn_value ECHO_OUTPUT_VARIABLE)
    
    execute_process(COMMAND ${CMAKE_COMMAND} -E echo "${return_value}")
	set(${rtn_var} "${rtn_value}" PARENT_SCOPE)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
    dk_callDKBatch(dk_test "FROM DKBatch" "dk_callDKBash.cmd" rtn_var)
    dk_echo()
	dk_echo("rtn_var = ${rtn_var}")
endfunction()
