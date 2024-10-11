#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)


if(LINUX OR RASPBERRY)
	dk_lib(pthread)
endif()


# MSYS2 (-lpthread)
if(MSYSTEM)
	dk_set(PTHREAD_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lpthread")
endif()
