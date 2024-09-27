#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

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
	
# DEBUG
#	dk_printVar(rtn_var)
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
