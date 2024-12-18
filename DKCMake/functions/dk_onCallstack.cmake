#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_onCallstack()
#
#	use this callback with the variable_watch function
#
#	EXAMPLE:  variable_watch(VARIABLE dk_onCallstack)
#
macro(dk_onCallstack variable access value current_list_file stack)
	#message("dk_onCallstack(${variable} ${access} ${value} ${current_list_file} ${stack})")
	if("${access}" STREQUAL "MODIFIED_ACCESS")
		if("${value}" STREQUAL "dk_set")
			return()
		endif()
		if("${value}" STREQUAL "dk_onCallstack")
			return()
		endif()
		set(this_stack "${variable} ${access} ${value} ${current_list_file} ${stack}")
		if("${this_stack}" STREQUAL "${prev_stack}")
			return()
		endif()
		dk_set(prev_stack "${variable} ${access} ${value} ${current_list_file} ${stack}")
		set(MAX_STACK_SIZE 99)
		set(CMAKE_STACK ${stack} CACHE INTERNAL "")
		list(LENGTH CMAKE_STACK CMAKE_STACK_SIZE)
			
		set(__FILE__ "${CMAKE_CURRENT_FUNCTION_LIST_FILE}" CACHE INTERNAL "")
		get_filename_component(__FILE__ "${__FILE__}" NAME)
		set(__LINE__ "${CMAKE_CURRENT_FUNCTION_LIST_LINE}" CACHE INTERNAL "")
		set(__FUNCTION__ "${CMAKE_CURRENT_FUNCTION}" CACHE INTERNAL "")
		dk_messageBox("${__FUNCTION__}")
		set(__ARGV__ "${ARGV}" CACHE INTERNAL "")
		string(TIMESTAMP __TIME__ "%M:%S:%f")
		string(SUBSTRING "${__TIME__}" 0 10 __TIME__)
		set(__TIME__ "${__TIME__}" CACHE INTERNAL "")
		
		###### CMAKE_SOURCE[] ######
		list(PREPEND CMAKE_TIME ${__TIME__})
		list(LENGTH CMAKE_TIME CMAKE_TIME_SIZE)
		if(${CMAKE_TIME_SIZE} GREATER ${MAX_STACK_SIZE})
			list(POP_BACK CMAKE_TIME)
		endif()
		set(CMAKE_TIME ${CMAKE_TIME} CACHE INTERNAL "")
		
		###### CMAKE_SOURCE[] ######
		list(PREPEND CMAKE_SOURCE ${__FILE__})
		list(LENGTH CMAKE_SOURCE CMAKE_SOURCE_SIZE)
		if(${CMAKE_SOURCE_SIZE} GREATER ${MAX_STACK_SIZE})
			list(POP_BACK CMAKE_SOURCE)
		endif()
		set(CMAKE_SOURCE ${CMAKE_SOURCE} CACHE INTERNAL "")
		
		###### CMAKE_LINENO[] ######
		list(PREPEND CMAKE_LINENO ${__LINE__})
		list(LENGTH CMAKE_LINENO CMAKE_LINENO_SIZE)
		if(${CMAKE_LINENO_SIZE} GREATER ${MAX_STACK_SIZE})
			list(POP_BACK CMAKE_LINENO)
		endif()
		set(CMAKE_LINENO ${CMAKE_LINENO} CACHE INTERNAL "")
	
		###### FUNCNAME ######
		list(PREPEND FUNCNAME ${__FUNCTION__})
		list(LENGTH FUNCNAME FUNCNAME_SIZE)
		if(${FUNCNAME_SIZE} GREATER ${MAX_STACK_SIZE})
			list(POP_BACK FUNCNAME)
		endif()
		set(FUNCNAME ${FUNCNAME} CACHE INTERNAL "")
	
		###### STACK_LEVEL ######
		list(PREPEND STACK_LEVEL ${CMAKE_STACK_SIZE})
		list(LENGTH STACK_LEVEL STACK_LEVEL_SIZE)
		if(${STACK_LEVEL_SIZE} GREATER ${MAX_STACK_SIZE})
			list(POP_BACK STACK_LEVEL)
		endif()
		set(STACK_LEVEL ${STACK_LEVEL} CACHE INTERNAL "")
		set(__LEVEL__ ${STACK_LEVEL_SIZE})
		
		unset(indent)
		set(i 4)
		while(${i} LESS ${__LEVEL__})
			set(indent "${indent}-")
			math(EXPR i "${i}+1")
		endwhile(${i} LESS ${__LEVEL__})
		set(indent "${indent}-> ")
		
		message("${indent}${__FUNCTION__}(${__ARGV__})")	
		#dk_echo("${cyan}${indent}${__TIME__}${__FILE__}:${__LINE__}   ${__FUNCTION__}(${__ARGV__})")
	endif()
endmacro()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_onCallstack()
endfunction()
