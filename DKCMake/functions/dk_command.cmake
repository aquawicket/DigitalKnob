#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_command( <cmd> [<arguments>] [OUTPUT_VARIABLE <variable>] [NO_HALT] [NOECHO] [NOMERGE])
#
#	<cmd>				The command to run
#	[<arguments>]	command arguments 
#	[OUTPUT_VARIABLE <variable>]
#	[NO_HALT]
#	[NOECHO]
#	[NOMERGE]
#
function(dk_command)
	dk_debugFunc()
	
	dk_getOptionValue(RESULT_VARIABLE       		${ARGV})
	dk_getOptionValue(RESULTS_VARIABLE    			${ARGV})
	dk_getOptionValue(OUTPUT_VARIABLE    			${ARGV})
	dk_getOptionValue(ERROR_VARIABLE 				${ARGV})
#	if(CMAKE_VERSION VERSION_GREATER "3.18")
#		dk_getOption(ECHO_OUTPUT_VARIABLE			${ARGV})
#		dk_getOption(ECHO_ERROR_VARIABLE			${ARGV})
#	endif()
#	dk_getOption(OUTPUT_STRIP_TRAILING_WHITESPACE	${ARGV})
#	
#	dk_getOption(NO_HALT 							${ARGV})
#	dk_getOption(NOECHO 							${ARGV})
	dk_getOption(NOMERGE 							${ARGV} REMOVE)
	dk_getOption(BASH_ENV							${ARGV} REMOVE)
	
	if(NOT NOMERGE)
		dk_mergeFlags("${ARGV}" MERGED)
	endif()
	
	#if(NOT OUTPUT_STRIP_TRAILING_WHITESPACE)
	#	list(APPEND MERGED OUTPUT_STRIP_TRAILING_WHITESPACE)
	#endif()
	#if(OUTPUT_VARIABLE)
	#	list(APPEND MERGED OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	#endif()
	##if(NO_HALT)
	#	list(APPEND MERGED NO_HALT)
	#endif()
	#if(NOECHO)
	#	list(APPEND MERGED NOECHO)
	#endif()
	
	if(BASH_ENV)
		dk_bashEnv(${MERGED})
	else()
		dk_executeProcess(${MERGED})
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
#dk_createOsMacros("dk_command")







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_command(echo "test dk_command")
endfunction()