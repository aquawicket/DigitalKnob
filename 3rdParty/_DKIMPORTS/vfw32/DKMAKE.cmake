#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# vfw32

if(NOT WIN)
	dk_undepend(vfw32)
	dk_return()
endif()

dk_findLibrary(vfw32.lib)



# MSYS2 (-lvfw32)
if(MSYSTEM)
	dk_set(VFW32_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=--lvfw32")
endif()
