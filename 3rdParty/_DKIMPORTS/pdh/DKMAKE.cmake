#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ pdh ############

dk_load(dk_builder)
if(NOT WIN)
	dk_undepend(pdh)
	dk_return()
endif()

dk_findLibrary(pdh)



# MSYS2 (-lpdh)
if(MSYSTEM)
	dk_set(PDH_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lpdh")
endif()