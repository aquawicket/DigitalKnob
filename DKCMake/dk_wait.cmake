include_guard()

##############################################################################
# dk_wait()
# 
#	Wait until a keypress or timeout has elapsed in seconds
#
#	@ARGV0:timeout (Optional)(Number) default = 60
#	@ARGV1:msg     (Optional)(String) default = "press and key to continue."
#
macro(dk_wait) 
	#DKDEBUGFUNC(${ARGV})
	dk_call(dk_debugFunc ${ARGV})
	set(argv_0 ${ARGV0})
	set(argv_1 ${ARGV1})
	
	#dk_isNumber(argv_0 isNumber)
	dk_call(dk_isNumber argv_0 isNumber)
	if(isNumber)
		set(timeout ${argv_0})
	else()
		set(timeout 60) # default
	endif()
	
	if(NOT argv_1)
		set(msg "press and key to continue.") # default
	else()
		set(msg ${argv_1})
	endif()

	if(${timeout} GREATER 0)
		set(timeout_str && timeout /t ${timeout}) 
		set(msg "${msg}. Waiting ${timeout} seconds...")
	else()
		set(timeout_str && timeout /t -1) # no timeout
	endif()
	
	if(WIN_HOST)	
		execute_process(COMMAND cmd /c echo ${msg} ${timeout_str} > nul WORKING_DIRECTORY C:/)
		return()
	endif()
	if(UNIX_HOST)
		execute_process(COMMAND bash -c "read -n 1 -s -r -p \"${msg}\"" OUTPUT_VARIABLE outVar)
		return()
	endif()	
	#dk_error("Not implemented for this platform")
	dk_call(dk_error "Not implemented for this platform")
endmacro()
