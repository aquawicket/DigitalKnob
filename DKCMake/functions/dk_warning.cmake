include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_warning(msg)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
function(dk_warning msg)
	dk_debugFunc("\${ARGV}")

	dk_log(WARNING "${ARGV0}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_warning("test dk_warning message")
endfunction()
