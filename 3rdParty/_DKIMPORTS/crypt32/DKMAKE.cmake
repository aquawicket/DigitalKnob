#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ crypt32 ############
# https://learn.microsoft.com/en-us/windows/win32/api/wincrypt
dk_load(dk_builder)
if(NOT WIN)
	dk_undepend(crypt32)
	dk_return()
endif()

dk_findLibrary(crypt32.lib)

# MSYS2 (-lcrypt32)
if(MSYSTEM)
	dk_set(CRYPT32_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lcrypt32")
endif()
