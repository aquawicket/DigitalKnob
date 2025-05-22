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

#################### dk_exit settings ##########################################
# set(dk_exit_PAUSE_ON_EXIT		1)
# set(dk_exit_PAUSE_ON_ERROR	1)
###############################################################################
# dk_exit(exit_code)
#
#	Exit cmake
#
function(dk_exit) # exit_code)
	dk_debugFunc()
	
	if(NOT exit_code)
		set(exit_code 0 CACHE INTERNAL "")
	endif()
	if(${ARGV0}) 
		if(${ARGV0} GREATER ${exit_code})
			set(exit_code ${ARGV0})
		endif()
	endif()
	
	if(${dk_exit_PAUSE_ON_EXIT})
		dk_echo("*** CMAKE dk_exit_PAUSE_ON_EXIT ***")
		set(PAUSE 1)
	endif()
	
	if(${dk_exit_PAUSE_ON_ERROR})
		if(${exit_code})
			dk_echo("*** CMAKE dk_exit_PAUSE_ON_ERROR ***")
			set(PAUSE 1)
		endif()
	endif()
	
	dk_echo("exit_code: ${exit_code}")
	
	if("${PAUSE}")
		dk_pause("Press any key to exit . . .")
	endif()
	
	
	if(CMAKE_SCRIPT_MODE_FILE)
		message("cmake_language(EXIT ${exit_code})")
		cmake_language(EXIT ${exit_code})  # => 3.29
	endif()
	
	### fallback methods ###
	if(Unix)
		execute_process(COMMAND killall -9 cmake)
	else()
		execute_process(COMMAND taskkill /IM cmake /F) #RESULT_VARIABLE result_variable RESULTS_VARIABLE results_variable OUTPUT_VARIABLE output_variable ERROR_VARIABLE error_variable OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_STRIP_TRAILING_WHITESPACE ECHO_OUTPUT_VARIABLE ECHO_ERROR_VARIABLE)
		#message("result_variable = ${result_variable}")
		#message("results_variable = ${results_variable}")
		#message("output_variable = ${output_variable}")
		#message("error_variable = ${error_variable}")
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_exit()
	#dk_exit(0)
	dk_exit(13)
endfunction()
