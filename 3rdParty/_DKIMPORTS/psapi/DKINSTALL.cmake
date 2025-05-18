#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://learn.microsoft.com/en-us/windows/win32/psapi/psapi-functions

if(NOT Windows)
	dk_undepend(psapi)
	dk_return()
endif()

dk_findLibrary(Psapi.lib)



# MSYS2 (-lPsapi)
if(MSYSTEM)
	dk_set(PSAPI_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lPsapi")
endif()