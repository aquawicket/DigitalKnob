# https://github.com/kiyolee/bzip2-win-build
#
# https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip

### VERSION ###
DKSET(BZIP2_VERSION 1.0.8)
DKSET(BZIP2_NAME bzip2-${BZIP2_VERSION})
DKSET(BZIP2_DL https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v${BZIP2_VERSION}.zip)
DKSET(BZIP2 ${3RDPARTY}/${BZIP2_NAME})


### INSTALL ###
DKINSTALL(${BZIP2_DL} bzip2-win-build ${BZIP2})


### DKPLUGINS LINK ###
DKINCLUDE(${BZIP2})
WIN_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
WIN_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)
#WIN_DEBUG_LIB(${BZIP2}/${OS}/libzip2.lib)
#WIN_RELEASE_LIB(${BZIP2}/${OS}/libzip2.lib)

#WIN_DEBUG_LIB(${BZIP2}/${OS}/${DEBUG_DIR}/libraryd.lib)
#WIN_RELEASE_LIB(${BZIP2}/${OS}/${RELEASE_DIR}/library.lib)
