#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_success(msg)
#
#	Print a success message to the console
#
#	@msg	- The message to print
#
function(dk_success msg)
	dk_debugFunc()

	dk_log(SUCCESS "${ARGV0}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_success("test dk_success message")
endfunction()
