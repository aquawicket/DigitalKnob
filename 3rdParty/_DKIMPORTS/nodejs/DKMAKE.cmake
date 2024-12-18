#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://nodejs.org/dist/v14.16.1/node-v14.16.1-win-x86.zip
# https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x64.zip


dk_validate(host_triple "dk_host_triple()")
### BINARY DISTRIBUTIONS (PORTABLE) ###
LINUX_ARM64_HOST_dk_set	(NODEJS_DL https://nodejs.org/dist/v19.8.1/node-v19.8.1-linux-arm64.tar.gz)
WIN_X86_HOST_dk_set		(NODEJS_DL https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x86.zip)
WIN_X86_64_HOST_dk_set	(NODEJS_DL https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x64.zip)
dk_assertVar(NODEJS_DL)

dk_importVariables(${NODEJS_DL})

### IMPORT ###
dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
dk_set(NODEJS_DIR ${DKTOOLS_DIR}/${NODEJS_FOLDER})
dk_import(${NODEJS_DL} PATH ${NODEJS_DIR})
dk_set(NODE_EXE ${NODEJS_DIR}/node.exe)
dk_set(NPM_EXE ${NODEJS_DIR}/npm.cmd)
#dk_getNativePath(${NODE_EXE} NODE_EXE_WINPATH)
#dk_setEnv("PATH" "${NODEJS_DIR}")

#dk_command(${NPM_EXE} install --save glob -g)
