include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


##################################################################################
# dk_error(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a error dk_echo to the console
#
#	@msg	- The dk_echo to print
#
function(dk_error msg)
	dk_debugFunc(${ARGV})
	
	dk_log(ERROR "${ARGV0}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_error("test dk_error message")
endfunction()
