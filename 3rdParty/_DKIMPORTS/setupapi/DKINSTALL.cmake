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


###### setipapi ######
# https://learn.microsoft.com/en-us/windows/win32/api/setupapi

dk_validate(Target_Tuple "dk_Target_Tuple()")

if(NOT Windows)
	dk_disable(setupapi)
	dk_return()
endif()

dk_findLibrary(Setupapi.lib)



# MSYS2 (-lsetupapi)
if(MSYSTEM)
	dk_set(setupapi_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lsetupapi")
endif()
