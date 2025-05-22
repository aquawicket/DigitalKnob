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

##################################################################################
# dk_fatal(msg)
#
#	Print a fatal message to the console
#
#	@msg	- The message to print
#
function(dk_fatal msg)
	dk_debugFunc()

	dk_getParameter(NO_HALT  REMOVE)
	
	dk_log(FATAL "${ARGV0}" ${NO_HALT})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_fatal("test dk_fatal message w/ NO HALT" NO_HALT)
	dk_fatal("test dk_fatal message")
endfunction()
