#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_inputBox(msg, rtn_var)
#
#
function(dk_inputBox rtn_var)
	dk_debugFunc()
	
	dk_callDKBatch(dk_inputBox output)
	set(${rtn_var} ${output} PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_inputBox(result)
	dk_printVar(result)
endfunction()