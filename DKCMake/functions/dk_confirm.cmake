#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

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
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_confirm(result)
	if(result)
		dk_echo("the confimation has passed")
	else()
		dk_echo("the confimation has failed")
	endif()
endfunction()