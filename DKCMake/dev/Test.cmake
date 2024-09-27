#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


dk_load(dk_getDirectories)
dk_getDirectories("${DIGITALKNOB_DIR}" DIR_LIST)
message("DIR_LIST = ${DIR_LIST}")

dk_debug("Put code to test in this file")