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
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
