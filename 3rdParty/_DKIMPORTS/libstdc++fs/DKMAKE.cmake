#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# libstdc++fs

dk_if(LINUX     "dk_lib(libstdc++fs.a)")
dk_if(RASPBERRY "dk_lib(libstdc++fs.a)")