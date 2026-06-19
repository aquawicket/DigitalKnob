#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
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