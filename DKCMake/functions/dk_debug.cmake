include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
##include_guard()


##################################################################################
# dk_debug(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
function(dk_debug msg)
	dk_debugFunc("\${ARGV}")
	
	dk_log(DEBUG "${ARGV0}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_debug("test dk_debug message")
endfunction()
