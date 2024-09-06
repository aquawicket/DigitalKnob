include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_success(msg)
#
#	Print a success message to the console
#
#	@msg	- The message to print
#
function(dk_success msg)
	dk_debugFunc(${ARGV})

	dk_log(SUCCESS "${ARGV0}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_success("test dk_success message")
endfunction()
