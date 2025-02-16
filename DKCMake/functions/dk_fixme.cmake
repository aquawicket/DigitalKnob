#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()


##################################################################################
# dk_fixme(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a fixme message to the console
#
#	@msg	- The message to print
#
function(dk_fixme) #msg
	dk_debugFunc()

	dk_log(FIXME "${ARGV0}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc()

	dk_fixme("test dk_fixme message")
endfunction()
