#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
if(NOT WIN)
	dk_undepend(pdh.lib)
	dk_return()
endif()

dk_findLibrary(pdh.lib)



# MSYS2 (-lpdh)
if(MSYSTEM)
	#dk_set(PDH_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lpdh")
	#dk_append(CMAKE_CXX_LINK_EXECUTABLE -lpdh PARENT_SCOPE)
	dk_append(CMAKE_EXE_LINKER_FLAGS -lpdh PARENT_SCOPE)
endif()