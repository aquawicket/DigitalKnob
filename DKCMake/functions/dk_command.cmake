include_guard()

###############################################################################
# dk_command(commands) NOASSERT NOECHO OUTPUT_VARIABLE
#
#	TODO
#
#	@args	- TODO
#
function(dk_command)
	DKDEBUGFUNC(${ARGV})
	
	dk_get_option(NOASSERT ${ARGV})
	if(NOASSERT)
		set(EXTRA_ARGS ${EXTRA_ARGS} NOASSERT)
	endif()
	
	dk_get_option(NOECHO ${ARGV})
	if(NOECHO)
		set(EXTRA_ARGS ${EXTRA_ARGS} NOECHO)
	endif()
	
	dk_get_option_value(OUTPUT_VARIABLE ${ARGV})
	if(OUTPUT_VARIABLE)
		set(EXTRA_ARGS ${EXTRA_ARGS} OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	endif()
	
	dk_mergeFlags("${ARGV}" merged_args)
	#string(REPLACE ";" " " spaced_args "${merged_args}")
	#dk_info("\n${CLR}${magenta} dk_command> ${spaced_args}\n")
	
	#if(EMSCRIPTEN)
	#	dk_executeProcess(${EMMAKE} bash ${merged_args})
	#else()
	
	if(MINGW)
		dk_msys2_bash(${merged_args} ${EXTRA_ARGS})
	else()
		dk_executeProcess(${merged_args} ${EXTRA_ARGS})
	endif()
	
	if(OUTPUT_VARIABLE)
		set(${OUTPUT_VARIABLE} ${${OUTPUT_VARIABLE}} PARENT_SCOPE)
	endif()
endfunction()
dk_createOsMacros("dk_command")
dk_createOsMacros("dk_command")