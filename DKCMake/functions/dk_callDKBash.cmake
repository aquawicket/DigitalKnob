#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_callDKBash(function, arguments..., rtn_var)
#
#
function(dk_callDKBash func rtn_var)
	dk_debugFunc("\${ARGV}")
	
	dk_validate(BASH_EXE "dk_depend(bash)")
	dk_validate(DKBASH_FUNCTIONS_DIR "dk_DKBRANCH_DIR()")
    
    #dk_echo("${func}(${ARGN})")
    dk_set(DKBASH_COMMAND "${BASH_EXE}" -c "${DKBASH_FUNCTIONS_DIR}/${func}.sh" '${ARGN}')
	dk_echo("${DKBASH_COMMAND}")
    execute_process(COMMAND ${DKBASH_COMMAND} WORKING_DIRECTORY "${DKBASH_FUNCTIONS_DIR}" OUTPUT_VARIABLE rtn_value ECHO_OUTPUT_VARIABLE OUTPUT_STRIP_TRAILING_WHITESPACE)
    
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
	
	dk_callDKBash(dk_test rtn_var "FROM DKCmake" "dk_callDKBash.cmake")
    dk_echo()
	dk_echo("rtn_var = ${rtn_var}")
endfunction()
