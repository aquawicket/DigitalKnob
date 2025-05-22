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
function(dk_append variable)
	dk_debugFunc()
	#set(variable ${ARGV0})

	if(NOT ARGN)
		dk_warning("dk_append(${variable}) ARGN:${ARGN} is invalid")
		return()
	endif()
	if(${variable})
		dk_set(${variable} ${${variable}} ${ARGN})
	else()
		dk_set(${variable} ${ARGN})
	endif()
endfunction()






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
