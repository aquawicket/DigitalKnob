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


###### simple-getch ######
# https://github.com/mouuff/simple-getch
# https://github.com/mouuff/simple-getch/archive/refs/heads/master.zip

if(NOT UNIX_HOST)
	dk_disable(simple-getch)
	dk_return()
endif()


#dk_import(https://github.com/mouuff/simple-getch.git)
dk_import(https://github.com/mouuff/simple-getch/archive/refs/heads/master.zip)


### LINK ###
dk_include		(${SIMPLE_GETCH}/getch/include)
dk_libDebug		(${SIMPLE_GETCH}/getch/libgetch.a)
dk_libRelease	(${SIMPLE_GETCH}/getch/libgetch.a)


### COMPILE ###
#DEBUG_dk_exec	(../../make)
#RELEASE_dk_exec(../../make)
dk_build()
