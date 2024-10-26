#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ dxva2 ############
# https://learn.microsoft.com/en-us/windows/win32/medfound/about-dxva-2-0
# https://dll.website/dxva2-dll
dk_load(dk_builder)
if(NOT WIN)
	dk_undepend(dxva2)
	dk_return()
endif()

dk_findLibrary(Dxva2.dll)
