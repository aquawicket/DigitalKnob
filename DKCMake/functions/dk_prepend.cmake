#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_prepend(<variable> <value>)
#
#	<variable>	- The name of a variable to declare
#	<value>		- The value to add to the variable.
#
function(dk_prepend variable) #value
	dk_debugFunc()
	
	if(NOT ARGN)
		dk_warning("dk_prepend(${variable}) ARGN:${ARGN} is invalid")
		dk_return()
	endif()
	if(${variable})
		dk_set(${variable} ${ARGN} ${${variable}})
	else()
		dk_set(${variable} ${ARGN})
	endif()
	
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()