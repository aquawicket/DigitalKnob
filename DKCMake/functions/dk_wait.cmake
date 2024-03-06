include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


##############################################################################
# dk_wait([timeout] [msg])
# 
#	Wait until a keypress or timeout has elapsed in seconds
#
#	@timeout:(Optional)	- default = 60
#	@msg:(Optional)		- default = "press and key to continue."
#
macro(dk_wait) 
	DKDEBUGFUNC(${ARGV})
	
	dk_isNumber("${ARGV0}" isNumber)
	if(isNumber)
		set(timeout ${ARGV0})
		set(msg "${ARGV1}") 
	else()
		set(timeout 60) # default
		set(msg "${ARGV0}")
	endif()
	
	message(STATUS "\n\n${msg}\nWaiting ${timeout} seconds...\npress and key to continue.")
	
	math(EXPR timeout_p1 ${timeout}+1)
	if(WIN32)
		execute_process(COMMAND cmd /c "timeout ${timeout}" TIMEOUT ${timeout_p1})
	elseif(UNIX_HOST OR MINGW)
		execute_process(COMMAND bash -c "read -n 1 -r -s -t ${timeout}" TIMEOUT ${timeout_p1})
	else()
		dk_error("dk_wait(): Not implemented for this platform")
	endif()	
endmacro()
