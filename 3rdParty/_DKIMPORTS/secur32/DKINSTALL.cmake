#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### Secur32 ######
# https://www.file.net/process/secur32.dll.html

dk_validate(target_triple "dk_target_triple()")

if(NOT WIN)
	dk_undepend(secur32)
	dk_return()
endif()

dk_findLibrary(Secur32.Lib)



# MSYS2 (-lsecur32)
if(MSYSTEM)
	dk_set(SECUR32_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lsecur32")
endif()