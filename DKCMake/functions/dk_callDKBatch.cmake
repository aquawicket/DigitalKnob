#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_callDKBatch(func) args
#
#
function(dk_callDKBatch func rtn_var)
	dk_debugFunc("\${ARGV}")
	
	dk_validate(CMD_EXE "dk_depend(cmd)")
	dk_validate(DKBATCH_FUNCTIONS_DIR "dk_validateBranch()")
	execute_process(COMMAND cmd /c call "dk_messageBox.cmd" rtn_var ${ARGN} & echo %rtn_var% WORKING_DIRECTORY "${DKBATCH_FUNCTIONS_DIR}" OUTPUT_VARIABLE output_variable)
	dk_debug("output_variable = ${output_variable}")
	set(${rtn_var} "${output_variable}" PARENT_SCOPE)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_callDKBatch(dk_messageBox rtn_var "MessageBox Title" "Testing dk_messageBox")
	dk_debug("rtn_var = ${rtn_var}")
endfunction()
