#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_append(<variable> <value>)
#
#	<variable>	- The name of a variable. It will be created if it doesn't exist.
#	<value>		- The value to add to the variable.
#
#   FIXME: This can be a list or a string, but will always append as a list.
#		   We need a way to detect if the variable exists and is a list or a string.
#		   If the variable does not exist, we need to define if we are creating a list 
#		   or a string.
#
function(dk_append variable) #value
	dk_debugFunc()
	
	if(NOT ARGN)
		dk_warning("dk_append(${variable}) ARGN:${ARGN} is invalid")
		return()
	endif()
	if(${variable})
		dk_set(${variable} ${${variable}} ${ARGN})
	else()
		dk_set(${variable} ${ARGN})
	endif()

# DEBUG
#	dk_printVar(variable)
endfunction()
dk_createOsMacros("dk_append")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_append(MyVar "abc")
	dk_append(MyVar "123")
	dk_append(MyVar "def")
	list(APPEND MyVar "456")
	string(APPEND MyVar "ghi")
	dk_printVar(MyVar)
endfunction()
