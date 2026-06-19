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


############ deno ############
# https://github.com/denoland/deno

dk_import()

### LINK ###
dk_include			(${deno}/include)
if(MSVC)
	dk_libDebug		(${deno_Debug_Dir}/deno.lib)
	dk_libRelease	(${deno_Release_Dir}/deno.lib)
else()
	dk_libDebug		(${deno_Debug_Dir}/libdeno.a)
	dk_libRelease	(${deno_Release_Dir}/libdeno.a)
endif()

### GENERATE ###
dk_configure()


### COMPILE ###
dk_build()
