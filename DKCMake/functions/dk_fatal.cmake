#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_fatal(msg)
#
#	Print a fatal message to the console
#
#	@msg	- The message to print
#
function(dk_fatal msg)
	dk_debugFunc()

	dk_getOption(NO_HALT  ${ARGV} REMOVE)
	
	dk_log(FATAL "${ARGV0}" ${NO_HALT})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_fatal("test dk_fatal message")
endfunction()
