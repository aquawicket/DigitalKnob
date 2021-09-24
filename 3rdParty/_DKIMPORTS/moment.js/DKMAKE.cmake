# https://momentjs.com/downloads/moment.min.js

### VERSION ###
##DKSET(MOMENTJS_MAJOR 0)
##DKSET(MOMENTJS_MINOR 0)
##DKSET(MOMENTJS_BUILD 0)
#DKSET(MOMENTJS_VERSION ???)
DKSET(MOMENTJS_NAME moment.min)
DKSET(MOMENTJS_DL https://momentjs.com/downloads/moment.min.js)
DKSET(MOMENTJS ${3RDPARTY}/${MOMENTJS_NAME})

### INSTALL ###
DKINSTALL(${MOMENTJS_DL} moment.js ${MOMENTJS})
