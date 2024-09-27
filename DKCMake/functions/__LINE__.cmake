#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# __LINE__(rtn_var, frame)
#
#
macro(__LINE__ rtn_var)
	#dk_debugFunc(${ARGV})
	
	if(NOT DEFINED CMAKE_LINENO)
		set(${rtn_var} "CMAKE_CURRENT_LIST_LINE: ${CMAKE_CURRENT_LIST_LINE}")
	else()
		if(ARGV1)
			set(index ${ARGV1})
		else()
			set(index 0)
		endif()
#		#math(EXPR index "${index}+1" OUTPUT_FORMAT DECIMAL)	
		
		list(LENGTH CMAKE_LINENO CMAKE_LINENO_LENGTH)
		if(${index} GREATER ${CMAKE_LINENO_LENGTH})
			dk_echo(FATAL_ERROR "index:${index} out of range:${CMAKE_LINENO_LENGTH}")
		endif()
		list(GET CMAKE_LINENO ${index} ${rtn_var})
	endif()
	
# DEBUG
#	dk_printVar(rtn_var)
endmacro()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	#dk_debugFunc(${ARGV})
	
	list(LENGTH CMAKE_LINENO CMAKE_LINENO_LENGTH)
	dk_echo("CMAKE_LINENO:${CMAKE_LINENO_LENGTH} = ${CMAKE_LINENO}")
	__LINE__(_line_)
	dk_info("\${_line_} = ${_line_}")
	
	__LINE__(_line0_ 0)
	dk_info("\${_line0_} = ${_line0_}")

	__LINE__(_line1_ 1)
	dk_info("\${_line1_} = ${_line1_}")
	
	__LINE__(_line2_ 2)
	dk_info("\${_line2_} = ${_line2_}")

	list(LENGTH CMAKE_LINENO CMAKE_LINENO_LENGTH)
	dk_echo("CMAKE_LINENO:${CMAKE_LINENO_LENGTH} = ${CMAKE_LINENO}")
endfunction()
