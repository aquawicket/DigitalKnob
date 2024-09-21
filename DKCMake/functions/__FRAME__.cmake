include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

if(NOT COMMAND __FILE__)
	dk_load(${DKCMAKE_FUNCTIONS_DIR}/__FILE__.cmake)
endif()
if(NOT COMMAND __LINE__)
	dk_load(${DKCMAKE_FUNCTIONS_DIR}/__LINE__.cmake)
endif()
if(NOT COMMAND __FUNCTION__)
	dk_load(${DKCMAKE_FUNCTIONS_DIR}/__FUNCTION__.cmake)
endif()
##################################################################################
# __FRAME__(rtn_var, frame)
#
#
macro(__FRAME__ rtn_var)
	#dk_debugFunc(${ARGV})
	
	if(NOT DEFINED CMAKE_SOURCE)
		set(${rtn_var} "CMAKE_CURRENT_LIST_FILE: ${CMAKE_CURRENT_LIST_FILE}")
	else()
		if(ARGV1)
			set(index ${ARGV1})
		else()
			set(index 0)
		endif()
		
		list(LENGTH CMAKE_SOURCE CMAKE_SOURCE_LENGTH)
		if(${index} GREATER ${CMAKE_SOURCE_LENGTH})
			dk_echo(FATAL_ERROR "index:${index} out of range:${CMAKE_SOURCE_LENGTH}")
		endif()
#		#math(EXPR index "${index}+1" OUTPUT_FORMAT DECIMAL)	
		__FILE__(_file_ ${index})
		__LINE__(_line_ ${index})
		__FUNCTION__(_function_ ${index})
		#list(GET CMAKE_ARGV ${index} _argv_)
		#list(GET CALLER ${index} _caller_)
		set(${rtn_var} "${_file_}:${_line_}    ${_function_}()")
	endif()
	
# DEBUG
#	dk_printVar(rtn_var)
endmacro()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	#dk_debugFunc(${ARGV})
	
	list(LENGTH CMAKE_SOURCE CMAKE_SOURCE_LENGTH)
	dk_echo("CMAKE_SOURCE:${CMAKE_SOURCE_LENGTH} = ${CMAKE_SOURCE}")
	__FRAME__(_frame_)
	dk_info("\${_frame_} = ${_frame_}")
	
	__FRAME__(_frame0_ 0)
	dk_info("\${_frame0_} = ${_frame0_}")

	__FRAME__(_frame1_ 1)
	dk_info("\${_frame1_} = ${_frame1_}")
	
	__FRAME__(_frame2_ 2)
	dk_info("\${_frame2_} = ${_frame2_}")
	
	
	list(LENGTH CMAKE_SOURCE CMAKE_SOURCE_LENGTH)
	dk_echo("CMAKE_SOURCE:${CMAKE_SOURCE_LENGTH} = ${CMAKE_SOURCE}")
	__FRAME__(_frame_)
	dk_info("\${_frame_} = ${_frame_}")
	
	__FRAME__(_frame0_ 0)
	dk_info("\${_frame0_} = ${_frame0_}")

	__FRAME__(_frame1_ 1)
	dk_info("\${_frame1_} = ${_frame1_}")
	
	__FRAME__(_frame2_ 2)
	dk_info("\${_frame2_} = ${_frame2_}")
endfunction()
