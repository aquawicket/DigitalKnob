#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_callDKPowershell(function, arguments..., rtn_var)
#
#
function(dk_callDKPowershell func rtn_var) #args
	dk_debugFunc()
	dk_debug("dk_callDKPowershell(${ARGV}).cmake")
	
    ### get required variables ###
	dk_printVar(POWERSHELL_EXE)
    find_program(POWERSHELL_EXE powershell.exe)
	
	dk_validate(DKPOWERSHELL_FUNCTIONS_DIR "dk_DKBRANCH_DIR()")
	
    if(DEFINED ENV{WSL_DISTRO_NAME})
		# execute_process(COMMAND ${WSLPATH_EXE} -m "${DKPOWERSHELL_FUNCTIONS_DIR}" OUTPUT_VARIABLE DKPOWERSHELL_FUNCTIONS_DIR COMMAND_ECHO STDOUT OUTPUT_STRIP_TRAILING_WHITESPACE)
		# set(ENV{DKPOWERSHELL_FUNCTIONS_DIR} "${DKPOWERSHELL_FUNCTIONS_DIR}")
		dk_replaceAll("${DKPOWERSHELL_FUNCTIONS_DIR}" "/mnt/c" "C:" DKPOWERSHELL_FUNCTIONS_DIR)
	endif()
    
    
    ### get ALL_BUT_FIRST_ARGS ###
	#set(ALL_BUT_FIRST_ARGS              ${ARGN})
    
    ### get LAST_ARG ###
    #list(GET ARGN -1 LAST_ARG)
	#math(EXPR ARGC_LAST "${ARGC}-1")
	#set(ARGV_LAST ${ARGV${ARGC_LAST}})
	
	dk_assertVar(POWERSHELL_EXE)
	dk_printVar(POWERSHELL_EXE)
	
	dk_assertVar(DKPOWERSHELL_FUNCTIONS_DIR)
	dk_printVar(DKPOWERSHELL_FUNCTIONS_DIR)
    
    ### Call DKCmake function ###
    #set(DKPOWERSHELL_COMMAND ${POWERSHELL_EXE} -Command "$env:DKPOWERSHELL_FUNCTIONS_DIR=${DKPOWERSHELL_FUNCTIONS_DIR};" "\$env:DKSCRIPT_EXT=${DKSCRIPT_EXT};" . "\${DKPOWERSHELL_FUNCTIONS_DIR}/${func}.ps1;" "${func} ${ARGN}")
	set(DKPOWERSHELL_COMMAND ${POWERSHELL_EXE} -Command "$DKSCRIPT_EXT='${DKSCRIPT_EXT}';\n . ${DKPOWERSHELL_FUNCTIONS_DIR}/${func}.ps1;\n ${func} ${ARGN}")
    dk_echo("${DKPOWERSHELL_COMMAND}")
    execute_process(COMMAND ${DKPOWERSHELL_COMMAND} WORKING_DIRECTORY "${DKPOWERSHELL_FUNCTIONS_DIR}" OUTPUT_VARIABLE output OUTPUT_STRIP_TRAILING_WHITESPACE)
	

    ### process the return value ###
    #dk_echo("output = ${output}")
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
	
	dk_callDKPowershell(dk_test rtn_var "FROM DKCmake" "dk_callDKPowershell.cmake")
    dk_echo()
	dk_echo("rtn_var = ${rtn_var}")
endfunction()
