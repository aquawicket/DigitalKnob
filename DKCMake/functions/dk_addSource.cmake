#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_addSource(<regex>)
#
<<<<<<< HEAD
#	TODO
#
#	@regex	- TODO
#
function(dk_addSource regex)
	dk_debugFunc()
	
	dk_set(SRC_INCLUDE ${SRC_INCLUDE} ${ARGV})
	
# DEBUG
#	TODO
=======
#	Add a file or file pattern to the SRC_INCLUDE list variable
#
function(dk_addSource)
	dk_debugFunc(1)
	
	set(regex ${ARGV})
	dk_set(SRC_INCLUDE ${SRC_INCLUDE} ${regex})
>>>>>>> Development
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_addSource()
=======
	dk_debugFunc(0)
	
	dk_addSource("todo")
>>>>>>> Development
endfunction()
