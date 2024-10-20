#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://software-network.org/client/

WIN_dk_import(https://software-network.org/client/sw-master-windows-client.zip)
MAC_dk_import(https://software-network.org/client/sw-master-macos-client.tar.gz)
LINUX_dk_import(https://software-network.org/client/sw-master-linux-client.tar.gz)

dk_setEnv("PATH" "${SW_CLIENT}")
WIN_dk_set(SW_EXE ${SW_CLIENT}/sw.exe)
