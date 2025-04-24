#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
##include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development


##################################################################################
# dk_debug(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
function(dk_debug)
	dk_debugFunc()
	
<<<<<<< HEAD
	dk_log(DEBUG "${ARGV0}")
=======
	dk_getArg(0 message)
	
	dk_log(DEBUG "${message}")
>>>>>>> Development
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_debug("test dk_debug message" "test")
=======
	dk_debugFunc(0)
	
	dk_debug("test dk_debug message" "test")
	dk_debug()
>>>>>>> Development
endfunction()
