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


############ libx11 ############
# https://github.com/mirror/libx11.git
# https://www.x.org/
# https://www.x.org/releases/individual/lib/
# https://www.x.org/releases/individual/lib/libx11-1.6.10.tar.gz
# https://github.com/mirror/libx11/archive/refs/tags/libx11-1.8.1.zip

dk_import(https://github.com/mirror/libx11/archive/refs/tags/libx11-1.8.1.zip)

dk_include			(${libx11}/include)
if(Windows)
	dk_libDebug		(${libx11_Debug_Dir}/libx11d.lib)
	dk_libRelease	(${libx11_Release_Dir}/libx11.lib)
else()
	dk_libDebug		(${libx11_Debug_Dir}/liblibx11d.a)
	dk_libRelease	(${libx11_Release_Dir}/liblibx11.a)
endif()

dk_chdir			(${libx11_Build_Dir})
dk_exec				(${DKCONFIGURE_BUILD})

dk_build			(${libx11})
