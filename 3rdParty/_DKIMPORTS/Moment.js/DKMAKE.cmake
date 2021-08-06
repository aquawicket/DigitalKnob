# https://momentjs.com/downloads/moment.min.js

### VERSION ###
##DKSET(MOMENTJS_MAJOR 0)
##DKSET(MOMENTJS_MINOR 0)
##DKSET(MOMENTJS_BUILD 0)
#DKSET(MOMENTJS_VERSION ???)
DKSET(MOMENTJS_NAME Moment.js)
DKSET(MOMENTJS_DL https://momentjs.com/downloads/moment.min.js)
DKSET(MOMENTJS ${3RDPARTY}/${MOMENTJS_NAME})

### INSTALL ###
DKINSTALL(${MOMENTJS_DL} Moment.js ${MOMENTJS})


