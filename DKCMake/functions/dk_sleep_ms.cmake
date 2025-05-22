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
# dk_sleep_ms(milliseconds)
#
#	TODO
#
function(dk_sleep_ms)
	dk_debugFunc()
	###### Convert milliseconds to seconds ######
	# 1		    =      0.001
	# 12		=      0.012
	# 123 	    =      0.123
	# 1234	    =      1.234
	# 12345	    =     12.345
	# 123456	=    123.456
	# 1234567   =   1234.567
	# 12345678  =  12345.678
	# 123456789 = 123456.789
	
	set(milliseconds "00${ARGV0}")
	#message("milliseconds = ${milliseconds}")
	string(LENGTH "${milliseconds}" length)
	math(EXPR length "${length} - 3")
	string(SUBSTRING ${milliseconds} ${length} -1 right)
	string(SUBSTRING ${milliseconds} 0 ${length} left)
	set(seconds "${left}.${right}")
	#message("seconds = ${seconds}")

	execute_process(COMMAND ${CMAKE_COMMAND} -E sleep ${seconds})
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(milliseconds 3500)
	message("sleeping for ${milliseconds} milliseconds...")
	dk_sleep_ms(${milliseconds})
endfunction()
