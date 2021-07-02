### VERSION ###
DKSET(FLAC_VERSION 1.3.2)

### INSTALL ###
## https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.2-win.zip
## https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.2.tar.xz
DKINSTALL(https://ftp.osuosl.org/pub/xiph/releases/flac/flac-${FLAC_VERSION}-win.zip flac flac-${FLAC_VERSION})
DKSET(FLAC ${3RDPARTY}/flac-${FLAC_VERSION})


### LINK ###
DKINCLUDE(${FLAC})
WIN_DEBUG_LIB(${FLAC}/${OS}/${DEBUG}/flac.lib)
WIN_RELEASE_LIB(${FLAC}/${OS}/${RELEASE}/flac.lib)
APPLE_DEBUG_LIB(${FLAC}/${OS}/${DEBUG}/libflac.a)
APPLE_RELEASE_LIB(${FLAC}/${OS}/${RELEASE}/libflac.a)
LINUX_DEBUG_LIB(${FLAC}/${OS}/${DEBUG}/libflac.a)
LINUX_RELEASE_LIB(${FLAC}/${OS}/${RELEASE}/libflac.a)
ANDROID_DEBUG_LIB(${FLAC}/${OS}/$(LIBDIR)/libflac.a)
ANDROID_RELEASE_LIB(${FLAC}/${OS}/$(LIBDIR)/libflac.a)



### COMPILE ###
LINUX_PATH(${FLAC}/${OS}/${DEBUG})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
LINUX_DEBUG_COMMAND(make)

DKSETPATH(${FLAC}/${OS}/${RELEASE})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
LINUX_RELEASE_COMMAND(make)