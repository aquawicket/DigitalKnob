include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


dk_load(dk_getSubdirectories)
dk_getSubdirectories("${DIGITALKNOB_DIR}" DIR_LIST)
message("DIR_LIST = ${DIR_LIST}")

dk_debug("Put code to test in this file")