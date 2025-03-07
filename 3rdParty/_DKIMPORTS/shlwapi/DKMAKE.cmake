#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### shlwapi ######
# https://docs.microsoft.com/en-us/windows/win32/shell/shlwapi-wrappers


dk_load(dk_builder)

if(NOT WIN)
	dk_undepend(shlwapi)
	dk_return()
endif()

dk_findLibrary(shlwapi.lib)



# MSYS2 (-lshlwapi)
if(MSYSTEM)
	dk_set(SHLWAPI_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=--lshlwapi")
endif()