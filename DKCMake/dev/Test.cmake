#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()


dk_load(dk_getDirectories)
dk_getDirectories("${DIGITALKNOB_DIR}" DIR_LIST)
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


dk_load(dk_getDirectories)
dk_getDirectories("$ENV{DIGITALKNOB_DIR}" DIR_LIST)
>>>>>>> Development
message("DIR_LIST = ${DIR_LIST}")

dk_debug("Put code to test in this file")