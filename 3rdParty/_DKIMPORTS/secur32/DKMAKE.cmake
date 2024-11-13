#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### Secur32 ######
# https://www.file.net/process/secur32.dll.html

dk_validate(triple "dk_TARGET_TRIPLE()")

if(NOT WIN)
	dk_undepend(secur32)
	dk_return()
endif()

dk_findLibrary(Secur32.Lib)



# MSYS2 (-lsecur32)
if(MSYSTEM)
	dk_set(SECUR32_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lsecur32")
endif()