#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# libstdc++fs

LINUX_dk_lib		(libstdc++fs.a)
RASPBERRY_dk_lib	(libstdc++fs.a)