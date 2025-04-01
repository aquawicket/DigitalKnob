#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://software-network.org/client/

WIN_dk_import(https://software-network.org/client/sw-master-windows-client.zip)
MAC_dk_import(https://software-network.org/client/sw-master-macos-client.tar.gz)
LINUX_dk_import(https://software-network.org/client/sw-master-linux-client.tar.gz)

dk_setEnv("PATH" "${SW_CLIENT}")
WIN_dk_set(SW_EXE ${SW_CLIENT}/sw.exe)
