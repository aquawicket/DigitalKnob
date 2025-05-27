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


###### WavPack ######
# https://github.com/dbry/WavPack/archive/d9c4a35.zip


### INSTALL ###
dk_import(https://github.com/dbry/WavPack/archive/d9c4a35.zip)


### LINK ###
dk_include			(${WAVPACK}/include)
dk_validate(Target_Tuple "dk_Target_Tuple()")
if(MSVC AND Windows)
	dk_libDebug		(${WAVPACK_DEBUG_DIR}/wavpack.lib)
	dk_libRelease	(${WAVPACK_RELEASE_DIR}/wavpack.lib)
else()
	dk_libDebug		(${WAVPACK_DEBUG_DIR}/libwavpack.a)
	dk_libRelease	(${WAVPACK_RELEASE_DIR}/libwavpack.a)
endif()

### GENERATE ###
dk_configure(${WAVPACK})


### COMPILE ###
dk_build(${WAVPACK} wavpack)
