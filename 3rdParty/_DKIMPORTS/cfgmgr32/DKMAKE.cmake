#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ cfgmgr32 ############
# https://learn.microsoft.com/en-us/windows/win32/api/setupapi
dk_load(dk_builder)
if(NOT WIN)
	dk_undepend(cfgmgr32.lib)
	dk_return()
endif()

dk_findLibrary(Cfgmgr32.lib)

# MSYS2 (-lCfgmgr32)
if(MSYSTEM)
	dk_set(CFGMGR32_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lCfgmgr32")
endif()
