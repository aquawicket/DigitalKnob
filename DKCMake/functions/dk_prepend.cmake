#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

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
<<<<<<< HEAD
dk_createOsMacros("dk_prepend")
=======

>>>>>>> Development






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()