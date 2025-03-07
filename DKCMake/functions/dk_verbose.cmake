#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
#include_guard()

##################################################################################
# dk_verbose(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
function(dk_verbose msg)
	dk_debugFunc()

	dk_log(VERBOSE "${ARGV0}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_verbose("test dk_verbose message")
endfunction()
