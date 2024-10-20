#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://learn.microsoft.com/en-us/windows/win32/api/userenv/

if(NOT WIN)
	dk_undepend(userenv)
	dk_return()
endif()

dk_findLibrary(Userenv.lib)



# MSYS2 (-lUserenv)
if(MSYSTEM)
	dk_set(USERENV_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lUserenv")
endif()