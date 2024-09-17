include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://nodejs.org/dist/v14.16.1/node-v14.16.1-win-x86.zip
# https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x64.zip


dk_validate(HOST_TRIPLE "dk_getHostTriple()")
### BINARY DISTRIBUTIONS (PORTABLE) ###
LINUX_ARM64_HOST_dk_set	(NODEJS_DL https://nodejs.org/dist/v19.8.1/node-v19.8.1-linux-arm64.tar.gz)
WIN_X86_HOST_dk_set		(NODEJS_DL https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x86.zip)
WIN_X86_64_HOST_dk_set	(NODEJS_DL https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x64.zip)

## Get NOTEPADPP_DL_FILE, NOTEPADPP_FOLDER
if(NOT NODEJS_DL)
	return()
endif()

dk_basename(${NODEJS_DL} NODEJS_DL_FILE)
dk_removeExtension(${NODEJS_DL_FILE} NODEJS_FOLDER)
dk_convertToCIdentifier(${NODEJS_FOLDER} NODEJS_FOLDER)

### IMPORT ###
dk_validate(DKTOOLS_DIR "dk_getDKPaths()")
dk_set(NODEJS ${DKTOOLS_DIR}/${NODEJS_FOLDER})
dk_import(${NODEJS_DL} PATH ${NODEJS})
dk_set(NODE_EXE ${NODEJS}/node.exe)
dk_set(NPM_EXE ${NODEJS}/npm.cmd)
#dk_getNativePath(${NODE_EXE} NODE_EXE_WINPATH)
#dk_setEnv("PATH" "${NODEJS}")

#dk_command(${NPM_EXE} install --save glob -g)
