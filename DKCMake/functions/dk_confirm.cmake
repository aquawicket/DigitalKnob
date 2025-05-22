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
# dk_confirm(rtn_var)
#
#
function(dk_confirm rtn_var)
	dk_debugFunc()

	dk_echo("${yellow} Are you sure ? [Y/N] ${clr}")
	
	dk_keyboardInput(REPLY)
	dk_echo()

	if("${REPLY}" STREQUAL "y") 
		#return(PROPAGATE 1)
		set(${rtn_var} TRUE PARENT_SCOPE)
	elseif("${REPLY}" STREQUAL "Y")
		#return(PROPAGATE 1)
		set(${rtn_var} TRUE PARENT_SCOPE)
	else()
		#return(PROPAGATE 0)
		set(${rtn_var} FALSE PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_confirm(result)
	if(result)
		dk_echo("the confimation has passed")
	else()
		dk_echo("the confimation has failed")
	endif()
endfunction()