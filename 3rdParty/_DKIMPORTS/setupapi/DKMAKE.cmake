#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### setipapi ######
# https://learn.microsoft.com/en-us/windows/win32/api/setupapi

dk_load(dk_builder)

if(NOT WIN)
	dk_undepend(setupapi)
	dk_return()
endif()

dk_findLibrary(Setupapi.lib)



# MSYS2 (-lsetupapi)
if(MSYSTEM)
	dk_set(SETUPAPI_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lsetupapi")
endif()
