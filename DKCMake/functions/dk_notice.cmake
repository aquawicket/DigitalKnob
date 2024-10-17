#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_notice(msg)
#
#	Print a NOTICE message
#
#	@msg	- The message to print
#
function(dk_notice msg)
	dk_debugFunc()
	
	dk_log(NOTICE "${ARGV0}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_notice("Test message from dk_notice")
endfunction()