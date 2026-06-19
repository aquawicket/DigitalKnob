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


############ nodejs ############
# https://nodejs.org
# https://nodejs.org/dist/v19.8.1/node-v19.8.1-linux-arm64.tar.gz
# https://nodejs.org/dist/v19.8.1/node-v19.8.1-linux-x64.tar.gz
# https://nodejs.org/dist/v19.8.1/node-v19.8.1-darwin-arm64.tar.gz
# https://nodejs.org/dist/v19.8.1/node-v19.8.1-darwin-x64.tar.gz
# https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x86.zip
# https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x64.zip

dk_import()

dk_set(node_exe "${nodejs}/node.exe")
dk_set(npm_exe "${nodejs}/npm.cmd")

#dk_pathToNative(${node_exe} node_exe_WINPATH)
#dk_setEnv("PATH" "${nodejs}")
#dk_exec(${npm_exe} install --save glob -g)
