# https://nodejs.org/dist/v14.16.1/node-v14.16.1-win-x86.zip

### VERSION ###
DKSET(NODEJS_VERSION v14.16.1)
DKSET(NODEJS_NAME node-${NODEJS_VERSION}-win-x86)
DKSET(NODEJS_DL https://nodejs.org/dist/${NODEJS_VERSION}/${NODEJS_NAME}.zip)
DKSET(NODEJS ${3RDPARTY}/${NODEJS_NAME})
DKSET(NODE_EXE ${NODEJS}/node.exe)


### INSTALL ###
DKINSTALL(${NODEJS_DL} nodejs ${NODEJS})
