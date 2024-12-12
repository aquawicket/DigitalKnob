#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### WavPack ######
# https://github.com/dbry/WavPack/archive/d9c4a35e822bb274b8c94fc95ff16c5b4c04d346.zip


### INSTALL ###
dk_import(https://github.com/dbry/WavPack/archive/d9c4a35.zip)


### LINK ###
dk_include			(${WAVPACK}/include)
if(UNIX)
	dk_libDebug		(${WAVPACK_DEBUG_DIR}/libwavpack.a)
	dk_libRelease	(${WAVPACK_RELEASE_DIR}/libwavpack.a)
else()
	dk_libDebug		(${WAVPACK_DEBUG_DIR}/wavpack.lib)
	dk_libRelease	(${WAVPACK_RELEASE_DIR}/wavpack.lib)
endif()

### GENERATE ###
dk_configure(${WAVPACK})


### COMPILE ###
dk_build(${WAVPACK} wavpack)
