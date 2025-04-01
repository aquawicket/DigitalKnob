#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ strmiids ############

dk_load(dk_builder)

if(NOT WIN)
	dk_undepend(strmiids)
	dk_return()
endif()

dk_findLibrary(strmiids.lib)



# MSYS2 (-lstrmiids)
if(MSYSTEM)
	dk_set(STRMIIDS_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lstrmiids")
endif()