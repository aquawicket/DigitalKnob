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
set(NODEJS_DL "${NodeJS_${Host_Tuple}_Import}")
dk_assertVar(NODEJS_DL)

dk_importVariables(${NODEJS_DL})

### IMPORT ###
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_set(NODEJS $ENV{DKTOOLS_DIR}/${NODEJS_FOLDER})
dk_import(${NODEJS_DL} _PATH_ ${NODEJS})
dk_set(NODE_EXE ${NODEJS}/node.exe)
dk_set(NPM_EXE ${NODEJS}/npm.cmd)
#dk_nativePath(${NODE_EXE} NODE_EXE_WINPATH)
#dk_setEnv("PATH" "${NODEJS}")

#dk_exec(${NPM_EXE} install --save glob -g)
