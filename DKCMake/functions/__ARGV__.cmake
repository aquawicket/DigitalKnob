#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# __ARGV__(rtn_var, frame)
#
#
macro(__ARGV__ rtn_var)
	#dk_debugFunc(${ARGV})
	
	if(${ARGV1})
		set(_FRAME_ ${ARGV1})
	else()
		set(_FRAME_ 0)
	endif()
	
	set(${rtn_var} ${ARGV} PARENT_SCOPE)

# DEBUG
#	dk_printVar(rtn_var)
endmacro()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	#dk_debugFunc(${ARGV})
	
	__ARGV__(ARGV)
	dk_info("\${ARGV} = ${ARGV}")
	
	__ARGV__(ARGV_0 0)
	dk_info("\${ARGV_0} = ${ARGV_0}")
	
	__ARGV__(ARGV_1 1)
	dk_info("\${ARGV_1} = ${ARGV_1}")
endfunction()
