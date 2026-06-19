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


############ version ############
# https://learn.microsoft.com/en-us/windows/win32/api/winver/nf-winver-getfileversioninfoa

if(NOT Windows)
	dk_disable(version)
	dk_return()
endif()

dk_findLibrary(version.lib)

# MSYS2 (-lversion)
if(MSYSTEM)
	dk_set(version_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lversion")
endif()
