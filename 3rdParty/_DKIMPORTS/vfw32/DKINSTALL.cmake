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


############ vfw32 ############

dk_validate(Target_Config  "dk_Target_Config()")

if(NOT Windows)
	dk_disable(vfw32)
	dk_return()
endif()

dk_findLibrary(vfw32.lib)



# MSYS2 (-lvfw32)
if(MSYSTEM)
	dk_set(VFW32_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=--lvfw32")
endif()
