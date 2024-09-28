#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://learn.microsoft.com/en-us/windows/win32/api/setupapi

if(NOT WIN)
	dk_undepend(setupapi)
	dk_return()
endif()

dk_findLibrary(Setupapi.lib)



# MSYS2 (-lsetupapi)
if(MSYSTEM)
	dk_set(SETUPAPI_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lsetupapi")
endif()
