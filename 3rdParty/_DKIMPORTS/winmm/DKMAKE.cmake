#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://docs.microsoft.com/en-us/windows/win32/multimedia/windows-multimedia-start-page?redirectedfrom=MSDN

if(NOT WIN)
	dk_undepend(winmm)
	dk_return()
endif()

dk_define(__WINDOWS_MM__)
dk_findLibrary(winmm.lib)


# MSYS2 (-lWinmm)
if(MSYSTEM)
	dk_set(WINMM_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lWinmm")
endif()
