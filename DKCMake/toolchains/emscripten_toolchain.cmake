#include_guard()

dk_echo(STATUS "##############################################################")
dk_echo(STATUS "################# emscripten_toolchain.cmake #################")
dk_echo(STATUS "##############################################################")


###### Get DKCMAKE_DIR ######

include($ENV{DKCMAKE_DIR}/functions/dk_load.cmake)
dk_load(${DKIMPORTS_DIR}/emsdk/DKMAKE.cmake)
dk_command(${EMSDK}/emsdk_env${bat})
dk_load(${EMSCRIPTEN_TOOLCHAIN_FILE})
dk_append(DKCMAKE_FLAGS	-DEMSCRIPTEN=ON)
