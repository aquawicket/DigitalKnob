include_guard()

###############################################################################
# dk_command( <cmd> [<arguments>] [OUTPUT_VARIABLE <variable>] [NOASSERT] [NOECHO] [NOMERGE])
#
#	<cmd>				The command to run
#	[<arguments>]	command arguments 
#	[OUTPUT_VARIABLE <variable>]
#	[NOASSERT]
#	[NOECHO]
#	[NOMERGE]
#
function(dk_command)
	DKDEBUGFUNC(${ARGV})
	
	dk_debug("dk_command(${ARGV})")
	dk_get_option_value(RESULT_VARIABLE		${ARGV})
	dk_get_option_value(RESULTS_VARIABLE 	${ARGV})
	dk_get_option_value(OUTPUT_VARIABLE 	${ARGV})
	dk_get_option_value(ERROR_VARIABLE 		${ARGV})
	dk_get_option(ECHO_OUTPUT_VARIABLE		${ARGV})
	dk_get_option(ECHO_ERROR_VARIABLE		${ARGV})
	
	dk_get_option(NOASSERT 					${ARGV})
	dk_get_option(NOECHO 					${ARGV})
	dk_get_option(NOMERGE 					${ARGV} REMOVE)
	dk_get_option(BASH_ENV					${ARGV} REMOVE)
	
	if(NOT NOMERGE)
		dk_mergeFlags("${ARGV}" ARGV)
	endif()
	
	#if(OUTPUT_VARIABLE)
	#	list(APPEND ARGV OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	#endif()
	##if(NOASSERT)
	#	list(APPEND ARGV NOASSERT)
	#endif()
	#if(NOECHO)
	#	list(APPEND ARGV NOECHO)
	#endif()
	
	if(BASH_ENV) #AND ((MINGW AND MSYSTEM) OR ANDROID))
		dk_bash_env(${ARGV})
	else()
		dk_executeProcess(${ARGV})
	endif()
	
	if(${RESULT_VARIABLE})
		set(${RESULT_VARIABLE} ${${RESULT_VARIABLE}} PARENT_SCOPE)
	endif()
	if(${RESULTS_VARIABLE})
		set(${RESULTS_VARIABLE} ${${RESULTS_VARIABLE}} PARENT_SCOPE)
	endif()
	if(${OUTPUT_VARIABLE})
		set(${OUTPUT_VARIABLE} ${${OUTPUT_VARIABLE}} PARENT_SCOPE)
	endif()
	if(${ERROR_VARIABLE})
		set(${ERROR_VARIABLE} ${${ERROR_VARIABLE}} PARENT_SCOPE)
	endif()
	if(${ECHO_OUTPUT_VARIABLE})
		set(${ECHO_OUTPUT_VARIABLE} ${${ECHO_OUTPUT_VARIABLE}} PARENT_SCOPE)
	endif()
	if(${ECHO_ERROR_VARIABLE})
		set(${ECHO_ERROR_VARIABLE} ${${ECHO_ERROR_VARIABLE}} PARENT_SCOPE)
	endif()
endfunction()
dk_createOsMacros("dk_command")