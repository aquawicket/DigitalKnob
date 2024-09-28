#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
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