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


############ tbb ############
# https://packages.msys2.org/package/mingw-w64-x86_64-tbb

if(MSYSTEM)
	dk_validate(msys2 "dk_depend(msys2)")
endif()
dk_installPackage(tbb)

# MSYS2 (-ltbb)
if(MSYSTEM)
	dk_set(tbb_Cmake "-DCMAKE_EXE_LINKER_FLAGS=-ltbb")
endif()
	
