#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


# https://software-network.org/client/

Windows_dkimport(https://software-network.org/client/sw-master-windows-client.zip)
Mac_dk_import(https://software-network.org/client/sw-master-macos-client.tar.gz)
Linux_dk_import(https://software-network.org/client/sw-master-linux-client.tar.gz)

dk_setEnv("PATH" "${sw-client}")
Windows_dk_set(sw_exe ${sw-client}/sw.exe)
