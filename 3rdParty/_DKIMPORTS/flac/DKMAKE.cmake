# https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.2-win.zip
# https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.2.tar.xz

### DEPENDS ###
DKDEPEND(nasm)

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
ANDROID_DEBUG_LIB(${FLAC}/${OS}/${DEBUG_DIR}/libflac.a)
ANDROID_RELEASE_LIB(${FLAC}/${OS}/${RELEASE_DIR}/libflac.a)


### 3rd Party Link ###
DKSET(FLAC_WIN -DFLAC_INCLUDE_DIR=${FLAC}/include -DFLAC_LIBRARY_DEBUG=${FLAC}/${OS}/${DEBUG_DIR}/flac.lib -DFLAC_LIBRARY_RELEASE=${FLAC}/${OS}/${RELEASE_DIR}/flac.lib)
DKSET(FLAC_APPLE -DFLAC_INCLUDE_DIR=${FLAC}/include -DFLAC_LIBRARY_DEBUG=${FLAC}/${OS}/${DEBUG_DIR}/flac.lib -DFLAC_LIBRARY_RELEASE=${FLAC}/${OS}/${RELEASE_DIR}/flac.lib)
DKSET(FLAC_LINUX_DEBUG -DFLAC_INCLUDE_DIR=${FLAC}/include -DFLAC_LIBRARY=${FLAC}/${OS}/${DEBUG_DIR}/libflac.a)
DKSET(FLAC_LINUX_RELEASE -DFLAC_INCLUDE_DIR=${FLAC}/include -DFLAC_LIBRARY=${FLAC}/${OS}/${RELEASE_DIR}/libflac.a)
DKSET(FLAC_RASPBERRY_DEBUG -DFLAC_INCLUDE_DIR=${FLAC}/include -DFLAC_LIBRAR=${FLAC}/${OS}/${DEBUG_DIR}/libflac.a)
DKSET(FLAC_RASPBERRY_RELEASE -DFLAC_INCLUDE_DIR=${FLAC}/include -DFLAC_LIBRARY=${FLAC}/${OS}/${RELEASE_DIR}/libflac.a)
DKSET(FLAC_ANDROID -DFLAC_INCLUDE_DIR=${FLAC}/include -DFLAC_LIBRARY_DEBUG=${FLAC}/${OS}/${DEBUG_DIR}/libflac.a -DFLAC_LIBRARY_RELEASE=${FLAC}/${OS}/${RELEASE_DIR}/libflac.a)





### COMPILE ###
WIN32_PATH(${FLAC}/${OS}/${DEBUG_DIR})
WIN32_BASH("#!/bin/bash 
cd /${FLAC}/${OS}/${DEBUG_DIR} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared
make 
exit \n")
WIN32_PATH(${FLAC}/${OS}/${RELEASE_DIR})
WIN32_BASH("#!/bin/bash 
cd /${FLAC}/${OS}/${RELEASE_DIR} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared
make 
exit \n")


WIN64_PATH(${FLAC}/${OS}/${DEBUG_DIR})
WIN64_BASH("#!/bin/bash 
cd /${FLAC}/${OS}/${DEBUG_DIR} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared
make 
exit \n")
WIN64_PATH(${FLAC}/${OS}/${RELEASE_DIR})
WIN64_BASH("#!/bin/bash 
cd /${FLAC}/${OS}/${RELEASE_DIR} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared
make 
exit \n")


MAC_DEBUG_PATH(${FLAC}/${OS}/${DEBUG_DIR})
MAC_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
MAC_DEBUG_COMMAND(make)
MAC_RELEASE_PATH(${FLAC}/${OS}/${RELEASE_DIR})
MAC_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
MAC_RELEASE_COMMAND(make)


LINUX_DEBUG_PATH(${FLAC}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
LINUX_DEBUG_COMMAND(make)
LINUX_RELEASE_PATH(${FLAC}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
LINUX_RELEASE_COMMAND(make)


RASPBERRY_DEBUG_PATH(${FLAC}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
RASPBERRY_DEBUG_COMMAND(make)
RASPBERRY_RELEASE_PATH(${FLAC}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
RASPBERRY_RELEASE_COMMAND(make)


ANDROID_DEBUG_PATH(${FLAC}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
ANDROID_DEBUG_COMMAND(make)
ANDROID_RELEASE_PATH(${FLAC}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
ANDROID_RELEASE_COMMAND(make)
