#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

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
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_messageBox("This is a test dk_messageBox")
endfunction()