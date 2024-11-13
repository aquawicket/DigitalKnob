#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_messageBox(msg, rtn_var)
#
#
function(dk_messageBox msg)
	dk_debugFunc()
	
	dk_callDKPowershell(dk_messageBox rtn_var "\"${msg}\"")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_messageBox("This is a test dk_messageBox")
endfunction()