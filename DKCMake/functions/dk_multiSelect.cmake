#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

##################################################################################
# dk_multiSelect(rtn_var)
#
#
function(dk_multiSelect input)
	dk_debugFunc()
	
	dk_callDKBatch(dk_multiSelect output)
	set(${input} ${output} PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_multiSelect(result)
	dk_printVar(result)
endfunction()