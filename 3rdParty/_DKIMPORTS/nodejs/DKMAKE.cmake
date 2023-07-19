# https://nodejs.org/dist/v14.16.1/node-v14.16.1-win-x86.zip
# https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x64.zip


### IMPORT ###
#dk_import(https://nodejs.org/dist/v14.16.1/node-v14.16.1-win-x86.zip)
dk_import(https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x64.zip)
dk_setEnv("PATH" "${NODEJS}")
dk_set(NODE_EXE ${NODEJS}/node.exe)
dk_set(NPM_EXE ${NODEJS}/npm.cmd)

#dk_command(${NPM_EXE} install --save glob -g)
