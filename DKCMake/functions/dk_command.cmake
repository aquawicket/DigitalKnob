#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

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
	
	dk_getParameterValue	(RESULT_VARIABLE)
	dk_getParameterValue	(RESULTS_VARIABLE)
	dk_getParameterValue	(OUTPUT_VARIABLE)
	dk_getParameterValue	(ERROR_VARIABLE)
	dk_getParameter		(NOMERGE 	REMOVE)
	dk_getParameter		(BASH_ENV	REMOVE)
	
	if(NOT NOMERGE)
		dk_mergeFlags("${ARGV}" MERGED)
	endif()
	
	if(BASH_ENV)
		dk_bashEnv(${MERGED})
	else()
		dk_exec(${MERGED})
	endif()

	if(${RESULT_VARIABLE})
		set(${RESULT_VARIABLE}	${${RESULT_VARIABLE}}	PARENT_SCOPE)
	endif()
	if(${RESULTS_VARIABLE})
		set(${RESULTS_VARIABLE}	${${RESULTS_VARIABLE}}	PARENT_SCOPE)
	endif()
	if(${OUTPUT_VARIABLE})
		set(${OUTPUT_VARIABLE}	${${OUTPUT_VARIABLE}}	PARENT_SCOPE)
	endif()
	if(${ERROR_VARIABLE})
		set(${ERROR_VARIABLE}	${${ERROR_VARIABLE}}	PARENT_SCOPE)
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_command(echo "test dk_command")
endfunction()
