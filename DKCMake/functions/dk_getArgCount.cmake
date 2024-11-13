#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_getArgCount(rtn_var args)
#
#	@rtn_var  - Returns the number of args received (minus the result argument)
#	@args 	 - a variable number of input arguments
#
function(dk_getArgCount rtn_var)
	dk_debugFunc()
	
	math(EXPR ARGC "${ARGC}-1")
	#dk_printVar(ARGC)
	set(${rtn_var} ${ARGC} PARENT_SCOPE)
	#dk_printVar(rtn_var)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()