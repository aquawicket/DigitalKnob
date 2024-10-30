#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_callDKBatch(function, arguments..., rtn_var)
#
#
function(dk_callDKBatch func rtn_var)
	dk_debugFunc()
	
    ### get required variables ###
	dk_validate(CMD_EXE                     "dk_depend(cmd)")
    dk_replaceAll("${CMD_EXE}" "/" "\\" CMD_EXE_WIN)
	dk_validate(DKBATCH_FUNCTIONS_DIR       "dk_DKBRANCH_DIR()")
    dk_replaceAll("${DKBATCH_FUNCTIONS_DIR}" "/" "\\" DKBATCH_FUNCTIONS_DIR_WIN)
    
    
    ### get ALL_BUT_FIRST_ARGS ###
	#set(ALL_BUT_FIRST_ARGS                  ${ARGN})
    
    ### get LAST_ARG ###
    #list(GET ARGN -1 LAST_ARG)
    
    
    ### Call DKBatch function ###
   # ${CMD_EXE_WIN}
    dk_set(DKBATCH_COMMAND cmd /V:ON /c "${DKBATCH_FUNCTIONS_DIR_WIN}\\${func}.cmd ${ARGN}")
	#dk_echo("${DKBATCH_COMMAND}")
    execute_process(COMMAND ${DKBATCH_COMMAND} WORKING_DIRECTORY "${DKBATCH_FUNCTIONS_DIR}" OUTPUT_VARIABLE output OUTPUT_STRIP_TRAILING_WHITESPACE) # COMMAND_ECHO STDOUT)
    
    ### process the return value ###
    dk_echo("output = ${output}")
    #if("${LAST_ARG}" STREQUAL "rtn_var")
        string(FIND "${output}" "\n" last_newline_pos REVERSE)  # Find the position of the last newline character
        if(last_newline_pos GREATER -1)
            string(SUBSTRING "${output}" ${last_newline_pos} -1 rtn_value) # Extract the last line
        else()
            set(rtn_value "${output}") # If no newline character was found, the whole string is the last line
        endif()
        string(STRIP "${rtn_value}" rtn_value)
        
        set(${rtn_var} "${rtn_value}" PARENT_SCOPE)
        execute_process(COMMAND ${CMAKE_COMMAND} -E echo "${rtn_value}")
    #endif()
    
# DEBUG
#	dk_printVar(rtn_value)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
    dk_callDKBatch(dk_test rtn_var "FROM DKCmake" "dk_callDKBatch.cmake")
	dk_echo("rtn_var = ${rtn_var}")
	
	#dk_callDKBatch(dk_registryKeyExists rtn_var "HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\QEMU")
	#dk_echo("rtn_var = ${rtn_var}")
endfunction()
