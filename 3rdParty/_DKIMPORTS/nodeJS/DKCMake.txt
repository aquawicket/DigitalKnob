### VERSION ###
DKSET(NODEJS_VERSION node-v14.16.1-win-x86)

### INSTALL ###
DKINSTALL(https://nodejs.org/dist/v14.16.1/node-v14.16.1-win-x86.zip nodejs ${NODEJS_VERSION})
DKSET(NODEJS ${3RDPARTY}/${NODEJS_VERSION})
DKSET(NODE_EXE ${NODEJS}/node.exe)