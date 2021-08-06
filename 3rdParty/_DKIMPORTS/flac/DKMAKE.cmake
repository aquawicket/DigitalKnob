# https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.2-win.zip
# https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.2.tar.xz

### VERSION ###
DKSET(FLAC_VERSION 1.3.2)
DKSET(FLAC_NAME flac-${FLAC_VERSION})
DKSET(FLAC_DL https://ftp.osuosl.org/pub/xiph/releases/flac/${FLAC_NAME}.tar.xz)
DKSET(FLAC ${3RDPARTY}/${FLAC_NAME})


### INSTALL ###
DKINSTALL(${FLAC_DL} flac ${FLAC})



### LINK ###
DKINCLUDE(${FLAC})
WIN_DEBUG_LIB(${FLAC}/${OS}/${DEBUG_DIR}/flac.lib)
WIN_RELEASE_LIB(${FLAC}/${OS}/${RELEASE_DIR}/flac.lib)
APPLE_DEBUG_LIB(${FLAC}/${OS}/${DEBUG_DIR}/libflac.a)
APPLE_RELEASE_LIB(${FLAC}/${OS}/${RELEASE_DIR}/libflac.a)
LINUX_DEBUG_LIB(${FLAC}/${OS}/${DEBUG_DIR}/libflac.a)
LINUX_RELEASE_LIB(${FLAC}/${OS}/${RELEASE_DIR}/libflac.a)
ANDROID_DEBUG_LIB(${FLAC}/${OS}/$(LIBDIR)/libflac.a)
ANDROID_RELEASE_LIB(${FLAC}/${OS}/$(LIBDIR)/libflac.a)



### COMPILE ###
LINUX_PATH(${FLAC}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
LINUX_DEBUG_COMMAND(make)

DKSETPATH(${FLAC}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
LINUX_RELEASE_COMMAND(make)