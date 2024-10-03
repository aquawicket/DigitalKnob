#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_callDKBatch(function, arguments..., rtn_var)
#
#
function(dk_callDKBatch func rtn_var)
	dk_debugFunc("\${ARGV}")
	
	dk_validate(CMD_EXE "dk_depend(cmd)")
    dk_replaceAll("${CMD_EXE}" "/" "\\" CMD_EXE_WIN)
	dk_validate(DKBATCH_FUNCTIONS_DIR "dk_DKBRANCH_DIR()")
    dk_replaceAll("${DKBATCH_FUNCTIONS_DIR}" "/" "\\" DKBATCH_FUNCTIONS_DIR_WIN)
    
    #dk_echo("${func}(${ARGN})")
    dk_set(DKBATCH_COMMAND "${CMD_EXE_WIN}" /V:ON /c "${DKBATCH_FUNCTIONS_DIR_WIN}\\${func}.cmd" '${ARGN}')
	dk_echo("${DKBATCH_COMMAND}")
    execute_process(COMMAND ${DKBATCH_COMMAND} WORKING_DIRECTORY "${DKBATCH_FUNCTIONS_DIR}" OUTPUT_VARIABLE rtn_value ECHO_OUTPUT_VARIABLE OUTPUT_STRIP_TRAILING_WHITESPACE)
    
    string(FIND "${rtn_value}" "\n" last_newline_pos REVERSE)  # Find the position of the last newline character
    if(last_newline_pos GREATER -1)
        string(SUBSTRING "${rtn_value}" ${last_newline_pos} -1 last_line) # Extract the last line
    else()
        set(last_line "${rtn_value}") # If no newline character was found, the whole string is the last line
    endif()
    string(STRIP "${last_line}" last_line)
    
	set(${rtn_var} "${last_line}" PARENT_SCOPE)
    execute_process(COMMAND ${CMAKE_COMMAND} -E echo "${last_line}")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
    dk_callDKBatch(dk_test rtn_var "FROM DKCmake" "dk_callDKBatch.cmake")
    dk_echo()
	dk_echo("rtn_var = ${rtn_var}")
endfunction()
