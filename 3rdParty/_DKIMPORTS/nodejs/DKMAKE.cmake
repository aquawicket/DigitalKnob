# https://nodejs.org/dist/v14.16.1/node-v14.16.1-win-x86.zip


### IMPORT ###
dk_import(https://nodejs.org/dist/v14.16.1/node-v14.16.1-win-x86.zip)
dk_setEnv("PATH" "${NODEJS}")
dk_set(NODE_EXE ${NODEJS}/node.exe)
dk_set(NPM_EXE ${NODEJS}/npm.cmd)