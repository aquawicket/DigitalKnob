#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_queueCommand(args) NO_HALT NOECHO NOMERGE
#
#	TODO
#
#	@args	- TODO
#
function(dk_queueCommand)
	dk_debugFunc()
	
	dk_debug("dk_queueCommand(${ARGV})")
	dk_getOptionValue(RESULT_VARIABLE		${ARGV})
	dk_getOptionValue(RESULTS_VARIABLE 		${ARGV})
	dk_getOptionValue(OUTPUT_VARIABLE 		${ARGV})
	dk_getOptionValue(ERROR_VARIABLE 		${ARGV})
	if(CMAKE_VERSION VERSION_GREATER "3.18")
		dk_getOption(ECHO_OUTPUT_VARIABLE	${ARGV})
		dk_getOption(ECHO_ERROR_VARIABLE	${ARGV})
	endif()
	dk_getOption(NO_HALT 					${ARGV})
	dk_getOption(NOECHO 					${ARGV})
	dk_getOption(NOMERGE 					${ARGV})
	dk_getOption(BASH_ENV					${ARGV})
	
	if(QUEUE_BUILD)
		dk_command(${ARGV})
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
endfunction()
dk_createOsMacros("dk_queueCommand")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()