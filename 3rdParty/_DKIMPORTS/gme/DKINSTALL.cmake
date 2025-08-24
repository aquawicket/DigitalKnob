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


###### gme ######
# https://github.com/libgme/game-music-emu


### INSTALL ###
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import		(${GME_DL})

### LINK ###
dk_include			(${GME}/include)
if(Unix)
	dk_libDebug		(${GME.Debug_Dir}/gme/libgme.a)
	dk_libRelease	(${GME.Release_Dir}/gme/libgme.a)
else()
	dk_libDebug		(${GME.Debug_Dir}/gme/gme.lib)
	dk_libRelease	(${GME.Release_Dir}/gme/gme.lib)
endif()

### GENERATE ###
dk_configure()


### COMPILE ###
dk_build()
