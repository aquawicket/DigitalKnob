#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

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
	
<<<<<<< HEAD
	dk_getOptionValue(RESULT_VARIABLE	${ARGV})
	dk_getOptionValue(RESULTS_VARIABLE 	${ARGV})
	dk_getOptionValue(OUTPUT_VARIABLE 	${ARGV})
	dk_getOptionValue(ERROR_VARIABLE 	${ARGV})
=======
	dk_getOptionValue(RESULT_VARIABLE)
	dk_getOptionValue(RESULTS_VARIABLE)
	dk_getOptionValue(OUTPUT_VARIABLE)
	dk_getOptionValue(ERROR_VARIABLE)
>>>>>>> Development
	
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
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_queueCommand("echo \"testing dk_queueCommand\"")
endfunction()
