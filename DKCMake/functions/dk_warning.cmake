#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_warning(msg)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
function(dk_warning msg)
	dk_debugFunc()

	dk_log(WARNING "${ARGV0}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_warning("test dk_warning message")
endfunction()
