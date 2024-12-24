#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_sleepMs(milliseconds)
#
#	TODO
#
function(dk_sleepMs)
	dk_debugFunc()
	
	set(milliseconds "${ARGV0}")
	#message("milliseconds = ${milliseconds}")
	
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
	string(LENGTH "${milliseconds}" length)
	while(${length} LESS 4)
		set(milliseconds 0${milliseconds})
		math(EXPR length "${length} + 1")
	endwhile()
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
	
	dk_sleepMs(500)
endfunction()
