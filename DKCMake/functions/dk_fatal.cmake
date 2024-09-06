include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_fatal(msg)
#
#	Print a fatal message to the console
#
#	@msg	- The message to print
#
function(dk_fatal msg)
	dk_debugFunc(${ARGV})

	dk_log(FATAL "${ARGV0}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_fatal("test dk_fatal message")
endfunction()
