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


### LINK ###
#DKDEFINE(USING_BZIP2)
#DKINCLUDE(${BZIP2}/include)
#DKINCLUDE(${BZIP2}/${OS})
#WIN_DEBUG_LIB(${BZIP2}/${OS}/${DEBUG_DIR}/libraryd.lib)
#WIN_RELEASE_LIB(${BZIP2}/${OS}/${RELEASE_DIR}/library.lib)
