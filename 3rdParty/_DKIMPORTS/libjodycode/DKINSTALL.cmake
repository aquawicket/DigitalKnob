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


############ libjodycode ############
# https://github.com/jbruchon/libjodycode.git

dk_import(https://github.com/jbruchon/libjodycode.git)

dk_include			(${libjodycode}/include)
if(Windows)
	dk_libDebug		(${libjodycode_Debug_Dir}/libjodycode.lib)
	dk_libRelease	(${libjodycode_Release_Dir}/libjodycode.lib)
else()
	dk_libDebug		(${libjodycode_Debug_Dir}/libjodycode.a)
	dk_libRelease	(${libjodycode_Release_Dir}/libjodycode.a)
endif()


### GENERATE ###
dk_configure()

### COMPILE ###
dk_build(${libjodycode} libjodycode)
