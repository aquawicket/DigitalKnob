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


############ crypt32 ############
# https://learn.microsoft.com/en-us/windows/win32/api/wincrypt

if(NOT Windows)
	dk_disable(crypt32)
	dk_return()
endif()

dk_findLibrary(crypt32.lib)

# MSYS2 (-lcrypt32)
if(MSYSTEM)
	dk_set(CRYPT32_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lcrypt32")
endif()
