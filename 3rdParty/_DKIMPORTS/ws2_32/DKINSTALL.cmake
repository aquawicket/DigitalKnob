#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ ws2_32 ############
# https://docs.microsoft.com/en-us/windows/win32/winsock/creating-a-basic-winsock-application
dk_load(dk_builder)

if(NOT WIN)
	dk_undepend(ws2_32)
	dk_return()
endif()

dk_findLibrary(ws2_32.lib)

# MSYS2 (-lws2_32)
if(MSYSTEM)
	dk_set(WS2_32_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lws2_32")
endif()
