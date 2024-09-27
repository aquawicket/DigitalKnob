#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)

LINUX_dk_lib		(pthread)
RASPBERRY_dk_lib	(pthread)


# MSYS2 (-lpthread)
if(MSYSTEM)
	dk_set(PTHREAD_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lpthread")
endif()
