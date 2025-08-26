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


############ deno ############
# https://github.com/denoland/deno



### INSTALL ###
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import		(Demo_Import)

### LINK ###
dk_include			(${DENO}/include)
if(MSVC)
	dk_libDebug		(${DENO_Debug_Dir}/deno.lib)
	dk_libRelease	(${DENO_Release_Dir}/deno.lib)
else()
	dk_libDebug		(${DENO_Debug_Dir}/libdeno.a)
	dk_libRelease	(${DENO_Release_Dir}/libdeno.a)
endif()

### GENERATE ###
dk_configure()


### COMPILE ###
dk_build()
