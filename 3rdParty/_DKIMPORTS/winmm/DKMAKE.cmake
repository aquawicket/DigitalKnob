#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ winmm ############
# https://docs.microsoft.com/en-us/windows/win32/multimedia/windows-multimedia-start-page?redirectedfrom=MSDN
dk_load(dk_builder)

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
