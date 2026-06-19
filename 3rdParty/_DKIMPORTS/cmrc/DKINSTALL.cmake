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


###### CMakeRC ######
# https://github.com/vector-of-bool/cmrc
# https://github.com/vector-of-bool/cmrc/archive/refs/heads/master.zip
# https://vector-of-bool.github.io/2017/01/21/cmrc.html

dk_import	(${CMakeRC_Import} NAME CMakeRC)

if(NOT CMAKE_SCRIPT_MODE_FILE)
	include	(${CMakeRC}/CMakeRC.cmake)
endif()

if(Debug)
	dk_include		(${CMakeRC_Debug_Dir}/_cmrc/include)
endif()
if(Release)
	dk_include		(${CMakeRC_Release_Dir}/_cmrc/include)
endif()
if(MSVC)
	dk_libDebug		(${CMakeRC_Debug_Dir}/cmakerc.lib)
	dk_libRelease	(${CMakeRC_Release_Dir}/cmakerc.lib)
else()
	dk_libDebug		(${CMakeRC_Debug_Dir}/libcmakerc.a)
	dk_libRelease	(${CMakeRC_Release_Dir}/libcmakerc.a)
endif()

dk_configure()

dk_build()