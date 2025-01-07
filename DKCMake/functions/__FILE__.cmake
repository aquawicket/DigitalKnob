#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

##################################################################################
# __FILE__(rtn_var, frame)
#
#
macro(__FILE__ file_rtn_var)
	#dk_debugFunc(${ARGV})
	
	if(NOT DEFINED CMAKE_SOURCE)
		set(${rtn_var} "CMAKE_CURRENT_LIST_FILE: ${CMAKE_CURRENT_LIST_FILE}")
	else()
		if(ARGV1)
			set(index ${ARGV1})
		else()
			set(index 0)
		endif()
#		#math(EXPR index "${index}+1" OUTPUT_FORMAT DECIMAL)	
		
		list(LENGTH CMAKE_SOURCE CMAKE_SOURCE_LENGTH)
		if(${index} GREATER ${CMAKE_SOURCE_LENGTH})
			dk_echo(FATAL_ERROR "index:${index} out of range:${CMAKE_SOURCE_LENGTH}")
		endif()
		list(GET CMAKE_SOURCE ${index} ${file_rtn_var})
	endif()
	
# DEBUG
#	dk_printVar(rtn_var)
endmacro()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	#dk_debugFunc(${ARGV})
	
	list(LENGTH CMAKE_SOURCE CMAKE_SOURCE_LENGTH)
	dk_echo("CMAKE_SOURCE:${CMAKE_SOURCE_LENGTH} = ${CMAKE_SOURCE}")
	__FILE__(_file_)
	dk_info("\${_file_} = ${_file_}")
	
	__FILE__(_file0_ 0)
	dk_info("\${_file0_} = ${_file0_}")

	__FILE__(_file1_ 1)
	dk_info("\${_file1_} = ${_file1_}")
	
	__FILE__(_file2_ 2)
	dk_info("\${_file2_} = ${_file2_}")

	list(LENGTH CMAKE_SOURCE CMAKE_SOURCE_LENGTH)
	dk_echo("CMAKE_SOURCE:${CMAKE_SOURCE_LENGTH} = ${CMAKE_SOURCE}")
endfunction()
