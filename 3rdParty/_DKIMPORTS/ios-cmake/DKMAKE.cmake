# https://github.com/leetal/ios-cmake
#
# https://github.com/leetal/ios-cmake/archive/refs/heads/master.zip

## Version ##
DKSET(IOSCMAKE_VERSION master)
DKSET(IOSCMAKE_NAME ios-${IOSCMAKE_VERSION})
DKSET(IOSCMAKE_DL https://github.com/leetal/ios-cmake/archive/refs/heads/${IOSCMAKE_VERSION}.zip)
DKSET(IOSCMAKE ${3RDPARTY}/${IOSCMAKE_NAME})

DKINSTALL(${IOSCMAKE_DL} ios-cmake ${IOSCMAKE}) 