# http://mingw-w64.org/doku.php
#
# https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/mingw-w64-v9.0.0.zip

### DEPENDS ###

### VERSION ###
DKSET(MINGW_VERSION 9.0.0)
DKSET(MINGW_NAME mingw-w64-v${MINGW_VERSION})
DKSET(MINGW_DL https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/${MINGW_NAME}.zip)
DKSET(MINGW ${3RDPARTY}/${MINGW_NAME})


### INSTALL ###
DKINSTALL(${MINGW_DL} mingw-w64 ${MINGW})



