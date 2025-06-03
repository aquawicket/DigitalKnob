#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


dk_validate(Config_Path  "dk_Config_Path()")
# https://software-network.org/client/

WIN_dk_import(https://software-network.org/client/sw-master-windows-client.zip)
MAC_dk_import(https://software-network.org/client/sw-master-macos-client.tar.gz)
LINUX_dk_import(https://software-network.org/client/sw-master-linux-client.tar.gz)

dk_setEnv("PATH" "${SW_CLIENT}")
Windows_dk_set(SW_EXE ${SW_CLIENT}/sw.exe)
