include_guard()

###############################################################################
# dk_bash(args)
#
#	TODO
#
#	@args	- TODO
#
function(dk_bash)
	DKDEBUGFUNC(${ARGV})
	dk_info("\n${CLR}${magenta} bash> ${ARGV}\n")
	
	execute_process(COMMAND bash -c "${ARGV}"
		RESULT_VARIABLE result 
		ERROR_VARIABLE error 
		WORKING_DIRECTORY ${CURRENT_DIR} 
		OUTPUT_STRIP_TRAILING_WHITESPACE)
		
	if(NOT ${result} EQUAL 0)
		dk_debug(command	PRINTVAR)
		dk_debug(result		PRINTVAR)
		dk_debug(error		PRINTVAR)
	endif()
endfunction()
dk_createOsMacros("dk_bash")