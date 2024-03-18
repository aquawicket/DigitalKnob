include_guard()

###############################################################################
# dk_command( <cmd> [<arguments>] [OUTPUT_VARIABLE <variable>] [NOASSERT] [NOECHO] [NOMERGE])
#
#	<cmd>			The command to run
#	[<arguments>]	command arguments 
#	[OUTPUT_VARIABLE <variable>]
#
#	@args	- TODO
#
function(dk_command)
	DKDEBUGFUNC(${ARGV})
	#message(STATUS "dk_command(${ARGV})")
	
	dk_get_option(NOASSERT ${ARGV})
	dk_get_option(NOECHO ${ARGV})
	dk_get_option(NOMERGE ${ARGV})
	dk_get_option_value(OUTPUT_VARIABLE ${ARGV})

	if(NOT NOMERGE)
		dk_mergeFlags("${ARGV}" ARGV)
	endif()
	
	if(OUTPUT_VARIABLE)
		#set(EXTRA_ARGS ${EXTRA_ARGS} OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
		list(APPEND ARGV OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	endif()
	
	if(MINGW AND MSYSTEM OR ANDROID)
		#dk_msys2_bash(${ARGV} ${NOASSERT} ${NOECHO})
		dk_bash(${ARGV} ${NOASSERT} ${NOECHO})
	else()
		dk_executeProcess(${ARGV} ${NOASSERT} ${NOECHO})
	endif()
	
	if(OUTPUT_VARIABLE)
		set(${OUTPUT_VARIABLE} ${${OUTPUT_VARIABLE}} PARENT_SCOPE)
	endif()
endfunction()
dk_createOsMacros("dk_command")