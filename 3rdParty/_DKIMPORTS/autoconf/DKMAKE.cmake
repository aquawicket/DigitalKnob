#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://www.gnu.org/software/autoconf

ANDROID_HOST_dk_command(pkg install autoconf)