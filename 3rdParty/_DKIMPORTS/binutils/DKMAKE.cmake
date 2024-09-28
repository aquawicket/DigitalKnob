#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# binutils

# https://wiki.termux.com/wiki/ASM
if(ANDROID_HOST)
	dk_command(pkg install binutils)
endif()