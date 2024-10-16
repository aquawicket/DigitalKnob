#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### simple-getch ######
# https://github.com/mouuff/simple-getch
# https://github.com/mouuff/simple-getch/archive/refs/heads/master.zip

dk_load(dk_builder)

if(NOT UNIX_HOST)
	dk_undepend(simple-getch)
	dk_return()
endif()


#dk_import(https://github.com/mouuff/simple-getch.git)
dk_import(https://github.com/mouuff/simple-getch/archive/refs/heads/master.zip)


### LINK ###
dk_include		(${SIMPLE_GETCH}/getch/include)
dk_libDebug		(${SIMPLE_GETCH}/getch/libgetch.a)
dk_libRelease	(${SIMPLE_GETCH}/getch/libgetch.a)


### COMPILE ###
#DEBUG_dk_queueCommand	(../../make)
#RELEASE_dk_queueCommand(../../make)
dk_build(${SIMPLE_GETCH})
