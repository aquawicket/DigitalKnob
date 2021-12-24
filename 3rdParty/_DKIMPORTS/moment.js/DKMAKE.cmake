# https://github.com/moment/moment
# https://momentjs.com/
# 
# https://github.com/moment/moment/raw/2.29.1/moment.js
# https://momentjs.com/downloads/moment.min.js

### VERSION ###
DKSET(MOMENTJS_MAJOR 2)
DKSET(MOMENTJS_MINOR 29)
DKSET(MOMENTJS_BUILD 1)
DKSET(MOMENTJS_VERSION ${MOMENTJS_MAJOR}.${MOMENTJS_MINOR}.${MOMENTJS_BUILD})
DKSET(MOMENTJS_NAME moment.js-${MOMENTJS_VERSION})
DKSET(MOMENTJS_DL https://github.com/moment/moment/raw/${MOMENTJS_VERSION}/moment.js)
DKSET(MOMENTJS ${3RDPARTY}/${MOMENTJS_NAME})

### INSTALL ###
DKINSTALL(${MOMENTJS_DL} moment.js ${MOMENTJS})
