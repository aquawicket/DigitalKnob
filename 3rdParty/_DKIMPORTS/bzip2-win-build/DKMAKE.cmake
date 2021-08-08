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
DKCOPY(${BZIP2}/build-VS2019 ${BZIP2}/${OS} FALSE)



### DKPLUGINS LINK ###
DKINCLUDE(${BZIP2})
WIN_DEBUG_LIB(${BZIP2}/${OS}/${DEBUG_DIR}/libbz2-static.lib)
WIN_RELEASE_LIB(${BZIP2}/${OS}/${RELEASE_DIR}/libbz2-static.lib)



### 3RDPARTY LINK ###
DKSET(BZIP2_WIN -DBZIP2_INCLUDE_DIR=${BZIP2} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/${DEBUG_DIR}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/${RELEASE_DIR}/libbz2.a)



### COMPILE ###
WIN_PATH(${BZIP2}/${OS})
WIN_VS(${BZIP2_NAME} bzip2.sln bzip2-static)