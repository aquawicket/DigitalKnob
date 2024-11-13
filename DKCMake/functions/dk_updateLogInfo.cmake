#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_updateLogInfo()
#
#	Updates the STACK_HEADER variable with the current filename, line number, function name and arguments
#
macro(dk_updateLogInfo)
	dk_debugFunc()  # called in dk_debugFunc
	
	if(PRINT_CALL_DETAILS)
		set(STACK_HEADER "")
		if(NOT CMAKE_CURRENT_FUNCTION_LIST_FILE)
			if(PRINT_FILE_NAMES)
				dk_basename(${CMAKE_CURRENT_LIST_FILE} STACK_FILENAME)
				set(STACK_HEADER "${STACK_FILENAME}:")
			endif()
			if(PRINT_LINE_NUMBERS)		
				set(STACK_HEADER "${STACK_HEADER}${CMAKE_CURRENT_LIST_LINE}->")
			endif()	
		else()
			if(PRINT_FILE_NAMES)
				dk_basename(${CMAKE_CURRENT_FUNCTION_LIST_FILE} STACK_FILENAME)
				set(STACK_HEADER "${STACK_FILENAME}:")
			endif()
			if(PRINT_LINE_NUMBERS)	
				set(STACK_HEADER "${STACK_HEADER}${CMAKE_CURRENT_FUNCTION_LIST_LINE}->")
			endif()
		endif()
		if(PRINT_FUNCTION_NAMES)
			set(STACK_HEADER "${STACK_HEADER}${CMAKE_CURRENT_FUNCTION}")
			if(PRINT_FUNCTION_ARGUMENTS)
				set(STACK_HEADER "${STACK_HEADER}(${ARGV}): ")
			else()
				set(STACK_HEADER "${STACK_HEADER}(): ")
			endif()
		endif()
	endif()
endmacro()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()
