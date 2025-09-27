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


# https://nodejs.org/dist/v14.16.1/node-v14.16.1-win-x86.zip
# https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x64.zip

dk_validate(Target_Config  "dk_Target_Config()")

dk_validate(Host_Tuple "dk_Host_Tuple()")
set(nodejs_Import "${NodeJS_${Host_Tuple}_Import}")
dk_assertVar(nodejs_Import)

dk_importVariables(${nodejs_Import})

### IMPORT ###
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_set(nodejs $ENV{DKTOOLS_DIR}/${nodejs_FOLDER})
dk_import(${nodejs_Import} _PATH_ ${nodejs})
dk_set(node_exe "${nodejs}/node.exe")
dk_set(npm_exe "${nodejs}/npm.cmd")
#dk_nativePath(${node_exe} node_exe_WINPATH)
#dk_setEnv("PATH" "${nodejs}")

#dk_exec(${npm_exe} install --save glob -g)
