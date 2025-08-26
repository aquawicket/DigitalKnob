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


dk_validate(Target_Config  "dk_Target_Config()")
# https://github.com/mirror/libX11.git
# https://www.x.org/
# https://www.x.org/releases/individual/lib/
# https://www.x.org/releases/individual/lib/libX11-1.6.10.tar.gz


### IMPORT ###
#dk_import(https://github.com/mirror/libX11.git)
dk_import(https://github.com/mirror/libX11/archive/refs/tags/libX11-1.8.1.zip)



### LINK ###
dk_include				(${LIBX11}/include)
Unix_dk_libDebug		(${LIBX11_Debug_Dir}/liblibx11d.a)
Unix_dk_libRelease		(${LIBX11_Release_Dir}/liblibx11.a)
Windows_dk_libDebug		(${LIBX11_Debug_Dir}/libx11d.lib)
Windows_dk_libRelease	(${LIBX11_Release_Dir}/libx11.lib)


### GENERATE / COMPILE ###
DEBUG_dk_chdir			(${LIBX11_Debug_Dir})
DEBUG_dk_exec			(${DKCONFIGURE_BUILD})

RELEASE_dk_chdir		(${LIBX11_Release_Dir})
RELEASE_dk_exec			(${DKCONFIGURE_BUILD})

dk_build				(${LIBX11})
