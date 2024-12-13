#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### gme ######
# https://github.com/libgme/game-music-emu


### INSTALL ###
dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam	(${DKIMPORTS_DIR}/gme/gme.txt GME_IMPORT)
dk_import		(${GME_IMPORT})

### LINK ###
dk_include			(${GME}/include)
if(UNIX)
	dk_libDebug		(${GME_DEBUG_DIR}/libgme.a)
	dk_libRelease	(${GME_RELEASE_DIR}/libgme.a)
else()
	dk_libDebug		(${GME_DEBUG_DIR}/gme.lib)
	dk_libRelease	(${GME_RELEASE_DIR}/gme.lib)
endif()

### GENERATE ###
dk_configure(${GME})


### COMPILE ###
dk_build(${GME})
