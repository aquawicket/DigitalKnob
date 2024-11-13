#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_queueCommand(args) NO_HALT NOECHO NOMERGE
#
#	TODO
#
#
function(dk_queueCommand)
	dk_debugFunc()
	
	if(NOT QUEUE_BUILD)
		dk_return()
	endif()
	
	dk_getOptionValue(RESULT_VARIABLE	${ARGV})
	dk_getOptionValue(RESULTS_VARIABLE 	${ARGV})
	dk_getOptionValue(OUTPUT_VARIABLE 	${ARGV})
	dk_getOptionValue(ERROR_VARIABLE 	${ARGV})
	
	dk_command(${ARGV})
	
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





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_queueCommand("echo \"testing dk_queueCommand\"")
endfunction()
