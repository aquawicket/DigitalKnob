# https://nodejs.org/dist/v14.16.1/node-v14.16.1-win-x86.zip

### VERSION ###
dk_set(NODEJS_VERSION v14.16.1)
dk_set(NODEJS_NAME node-${NODEJS_VERSION}-win-x86)
dk_set(NODEJS_DL https://nodejs.org/dist/${NODEJS_VERSION}/${NODEJS_NAME}.zip)
dk_set(NODEJS ${3RDPARTY}/${NODEJS_NAME})
dk_set(NODE_EXE ${NODEJS}/node.exe)


### INSTALL ###
DKINSTALL(${NODEJS_DL} nodejs ${NODEJS})
