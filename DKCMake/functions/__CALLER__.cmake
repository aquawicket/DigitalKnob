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
# __CALLER__(rtn_var, frame)
#
#
macro(__CALLER__ rtn_var)
	#dk_debugFunc(${ARGV})
	
	if(${ARGV1})
		set(_FRAME_ ${ARGV1})
	else()
		set(_FRAME_ 0)
	endif()
	math(EXPR _FRAME_ "${_FRAME_}+1" OUTPUT_FORMAT DECIMAL)
	
	set(${rtn_var} "${CMAKE_CURRENT_FUNCTION}")
endmacro()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	#dk_debugFunc(${ARGV})
	
	__CALLER__(CALLER)
	dk_info("\${CALLER} = ${CALLER}")
	
	__CALLER__(CALLER_0 0)
	dk_info("\${CALLER_0} = ${CALLER_0}")

	__CALLER__(CALLER_1 1)
	dk_info("\${CALLER_1} = ${CALLER_1}")
endfunction()
