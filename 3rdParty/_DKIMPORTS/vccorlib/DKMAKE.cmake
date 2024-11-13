#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############## vccorlib ############
# vccorlib
dk_load(dk_builder)

if(NOT WIN)
	dk_undepend(vccorlib)
	dk_return()
endif()

dk_findLibrary(vccorlib.lib)

# MSYS2 (-lvccorlib)
if(MSYSTEM)
	dk_set(VCCORLIB_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lvccorlib")
endif()
