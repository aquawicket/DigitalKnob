#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://learn.microsoft.com/en-us/windows/win32/api/winver/nf-winver-getfileversioninfoa

if(NOT WIN)
	dk_undepend(version)
	dk_return()
endif()

dk_findLibrary(version.lib)



# MSYS2 (-lversion)
if(MSYSTEM)
	dk_set(VERSION_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lversion")
endif()