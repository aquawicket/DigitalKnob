#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# __ARGC__(rtn_var, frame)
#
#
macro(__ARGC__ rtn_var)
	#dk_debugFunc(${ARGV})
	
	if(${ARGV1})
		set(_FRAME_ ${ARGV1})
	else()
		set(_FRAME_ 0)
	endif()

	set(${rtn_var} ${ARGC})

# DEBUG
#	dk_printVar(rtn_var)
endmacro()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	#dk_debugFunc(${ARGV})
	
	__ARGC__(ARGC)
	dk_info("\${ARGC} = ${ARGC}")
	
	__ARGC__(ARGC_0 0)
	dk_info("\${ARGC_0} = ${ARGC_0}")
	
	__ARGC__(ARGC_1 1)
	dk_info("\${ARGC_1} = ${ARGC_1}")
endfunction()
