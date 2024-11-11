#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


##################################
# https://learn.microsoft.com/en-us/windows/win32/psapi/psapi-functions

dk_depend(windows-sdk)


dk_load(dk_builder)


if(NOT WIN)
#	dk_undepend(psapi)
#	dk_return()
endif()

dk_findLibrary(Psapi.lib)






#dk_append(CMAKE_EXE_LINKER_FLAGS -lPsapi)
if(MSYSTEM)
	dk_set(PSAPI_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lPsapi")
endif()