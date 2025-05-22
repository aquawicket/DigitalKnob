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
# dk_return()
#
#	Print the current cmake file and return
#
macro(dk_return)
	dk_debugFunc()
	
	#######################################################################################################################################
	#######################################################################################################################################
	#######################################################################################################################################
	#######################################################################################################################################
	##### We should check the previous directory to see where we might be returning to, as well as he PWD back to the previous PWD "OLDPWD"
	#####  Where dk_debugFunc is out function opener,  dk_return will be a closer. 
	
	#######################################################################################################################################
	#######################################################################################################################################
	#######################################################################################################################################
	#######################################################################################################################################
	
	
	if(PRINT_DKRETURNS)
		dk_debug("${CMAKE_CURRENT_LIST_FILE} -> dk_return()")
	endif()
	return()
endmacro()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
