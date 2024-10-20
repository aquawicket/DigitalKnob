#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# strmiids

if(NOT WIN)
	dk_undepend(strmiids)
	dk_return()
endif()

dk_findLibrary(strmiids.lib)



# MSYS2 (-lstrmiids)
if(MSYSTEM)
	dk_set(STRMIIDS_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lstrmiids")
endif()