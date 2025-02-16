#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

##################################################################################
# dk_callDKBatch(function, rtn_var, arguments...)
#
#
function(dk_callDKBatch func rtn_var)
	dk_debugFunc()
	
	message("dk_callDKBatch(${ARGV})")

	#dk_depend(cmd)	
	###### CMD ######
	if(EXISTS "$ENV{COMSPEC}")
		dk_set(CMD_EXE "$ENV{COMSPEC}")
	endif()
    #dk_replaceAll("${CMD_EXE}" "/" "\\" CMD_EXE_WIN)
	dk_validate(DKBATCH_FUNCTIONS_DIR       "dk_DKBRANCH_DIR()")
    dk_replaceAll("${DKBATCH_FUNCTIONS_DIR}" "/" "\\" DKBATCH_FUNCTIONS_DIR_WIN)
    
    
    ### get ALL_BUT_FIRST_ARGS ###
	#set(ALL_BUT_FIRST_ARGS                  ${ARGN})
    
    ### get LAST_ARG ###
    #list(GET ARGN -1 LAST_ARG)
    
    ### Call DKBatch function ###
   # ${CMD_EXE_WIN}
	dk_set(DKBATCH_COMMAND "${CMD_EXE}" /V:ON /c call "${DKBATCH_FUNCTIONS_DIR_WIN}\\${func}.cmd" ${ARGN} OUTPUT_VARIABLE _output_ ECHO_OUTPUT_VARIABLE WORKING_DIRECTORY "${DKBATCH_FUNCTIONS_DIR}" OUTPUT_STRIP_TRAILING_WHITESPACE)
	
	message("DKBATCH_COMMAND = ${DKBATCH_COMMAND}")
    execute_process(COMMAND ${DKBATCH_COMMAND})

    ### process the return value ###
    string(FIND "${_output_}" "\n" last_newline_pos REVERSE)  # Find the position of the last newline character
    if(last_newline_pos GREATER -1)
        string(SUBSTRING "${_output_}" ${last_newline_pos} -1 _output_) # Extract the last line
    endif()
    string(STRIP "${_output_}" _output_)
	
    set(${rtn_var} "${_output_}" PARENT_SCOPE)
    
# DEBUG
	#dk_echo("rtn_value = ${rtn_var}")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#execute_process(COMMAND ${CMD_EXE} /c echo "Hello World" OUTPUT_VARIABLE output ECHO_OUTPUT_VARIABLE)
    #dk_echo("output = ${output}")
	
	#execute_process(COMMAND ${CMD_EXE} /V:ON /c "set /p input=& echo !input!" OUTPUT_VARIABLE input)
    #dk_echo("input = ${input}")
	
    dk_callDKBatch(dk_test rtn_var "FROM DKCmake" "dk_callDKBatch.cmake")
	dk_echo("rtn_var = ${rtn_var}")
	
	#dk_callDKBatch(dk_registryKeyExists rtn_var "HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\QEMU")
	#dk_echo("rtn_var = ${rtn_var}")
endfunction()
