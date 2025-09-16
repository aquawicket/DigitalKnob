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


############ dxva2 ############
# https://learn.microsoft.com/en-us/windows/win32/medfound/about-dxva-2-0
# https://dll.website/dxva2-dll
dk_validate(Target_Config  "dk_Target_Config()")
if(NOT Windows)
	dk_disable(dxva2)
	dk_return()
endif()

dk_findLibrary(Dxva2.dll)
