#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### WavPack ######
# https://github.com/dbry/WavPack/archive/d9c4a35.zip


### INSTALL ###
dk_import(https://github.com/dbry/WavPack/archive/d9c4a35.zip)


### LINK ###
dk_include			(${WAVPACK}/include)
dk_validate(target_triple "dk_target_triple()")
if(MSVC AND WIN)
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
