include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_notice(msg)
#
#	Print a NOTICE message
#
#	@msg	- The message to print
#
function(dk_notice msg)
	dk_debugFunc(${ARGV})
	
	dk_log(NOTICE "${ARGV0}")
endfunction()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_notice("Test message from dk_notice")
endfunction()