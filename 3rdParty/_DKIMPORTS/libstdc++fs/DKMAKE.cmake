#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# libstdc++fs

if(LINUX OR RASPBERRY)
	dk_lib(libstdc++fs.a)
endif()
