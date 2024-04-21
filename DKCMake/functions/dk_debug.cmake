include_guard()

if(NOT DEFINED ENABLE_dk_debug)
	dk_set(ENABLE_dk_debug 1)
endif()
##################################################################################
# dk_debug(msg)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
function(dk_debug msg)
	#DKDEBUGFUNC(${ARGV})
	#message("dk_debug(${ARGV})")
	
	if(NOT ENABLE_dk_debug)
		return()
	endif()
		
	dk_printvar(msg)
		
	#dk_updateLogInfo()
	#message(DEBUG "${H_black}${STACK_HEADER}${clr}${blue} ${msg} ${clr}")

	message("${blue}${msg}${clr}")
endfunction()
