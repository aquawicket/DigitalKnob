#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-wrappers

if(NOT WIN)
	dk_undepend(shlwapi)
	dk_return()
endif()

dk_findLibrary(shlwapi.lib)



# MSYS2 (-lshlwapi)
if(MSYSTEM)
	dk_set(SHLWAPI_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=--lshlwapi")
endif()