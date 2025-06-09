#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# _TEMPLATE_(args)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
function(_TEMPLATE_)
	dk_debugFunc(0 1)
	
	dk_getArg(0 arg0)
	dk_getArg(1 arg1)
	
	dk_debug("_TEMPLATE_(${arg0}, ${arg1})")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	_TEMPLATE_("todo")
endfunction()
