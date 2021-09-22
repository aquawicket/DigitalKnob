# https://imagemagick.org/index.php
# https://github.com/ImageMagick/ImageMagick
#
# https://github.com/ImageMagick/ImageMagick/archive/refs/tags/7.1.0.zip
# http://ftp.icm.edu.pl/packages/ImageMagick/binaries/ImageMagick-7.1.0-portable-Q16-x86.zip

### DEPENDS ###
#DKDEPEND(ghostscript)

### VERSION ###
if(WIN)
	DKSET(IMAGEMAGICK_VERSION 7.1.0-portable-Q16-x86)
else()
	DKSET(IMAGEMAGICK_VERSION 7.1.0)
endif()
DKSET(IMAGEMAGICK_NAME ImageMagick-${IMAGEMAGICK_VERSION})
WIN_DKSET(IMAGEMAGICK_DL http://ftp.icm.edu.pl/packages/ImageMagick/binaries/${IMAGEMAGICK_NAME}.zip)
LINUX_DKSET(IMAGEMAGICK_DL https://github.com/ImageMagick/ImageMagick/archive/refs/tags/${IMAGEMAGICK_VERSION}.zip)
MAC_DKSET(IMAGEMAGICK_DL https://github.com/ImageMagick/ImageMagick/archive/refs/tags/${IMAGEMAGICK_VERSION}.zip )
DKSET(IMAGEMAGICK ${3RDPARTY}/${IMAGEMAGICK_NAME})
WIN_DKSET(IMAGEMAGICK_CONVERT ${IMAGEMAGICK}/convert.exe)


### INSTALL ###
DKINSTALL(${IMAGEMAGICK_DL} imagemagick ${IMAGEMAGICK})


### LINK ###
DKINCLUDE(${IMAGEMAGICK}/${OS})
#WIN_DEBUG_LIB(${IMAGEMAGICK}/${OS}/${DEBUG_DIR}/imagemagickd.lib)
#WIN_RELEASE_LIB(${IMAGEMAGICK}/${OS}/${RELEASE_DIR}/imagemagick.lib)
APPLE_DEBUG_LIB(${IMAGEMAGICK}/${OS}/${DEBUG_DIR}/libimagemagick.a)
APPLE_RELEASE_LIB(${IMAGEMAGICK}/${OS}/${RELEASE_DIR}/libimagemagick.a)
LINUX_DEBUG_LIB(${IMAGEMAGICK}/${OS}/${DEBUG_DIR}/libimagemagick.a)
LINUX_RELEASE_LIB(${IMAGEMAGICK}/${OS}/${RELEASE_DIR}/libimagemagick.a)
ANDROID_DEBUG_LIB(${IMAGEMAGICK}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libimagemagick.a)
ANDROID_RELEASE_LIB(${IMAGEMAGICK}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libimagemagick.a)


### COMPILE ###
#WIN_PATH(${IMAGEMAGICK}/${OS}/${DEBUG_DIR})
#WIN_BASH("#!/bin/bash\;
#cd /${IMAGEMAGICK}/${OS}/${DEBUG_DIR}\;
#export PATH=/${MINGW32}/bin:$PATH\;
#export PATH=/${MSYS}/bin:$PATH\;
#../../configure --disable-shared --enable-static\;
#make\;
#exit\;")

#WIN_PATH(${IMAGEMAGICK}/${OS})
#WIN32_COMMAND(${DKCMAKE_WIN32} ${IMAGEMAGICK})
#WIN64_COMMAND(${DKCMAKE_WIN64} ${IMAGEMAGICK})
#WIN_VS(${IMAGEMAGICK_NAME} imagemagick.sln imagemagick)


MAC_PATH(${IMAGEMAGICK}/${OS})
MAC64_COMMAND(${DKCMAKE_MAC64} ${IMAGEMAGICK})
MAC_XCODE(${IMAGEMAGICK_NAME} imagemagick)


IOS_PATH(${IMAGEMAGICK}/${OS})
IOS64_COMMAND(${DKCMAKE_IOS64} ${IMAGEMAGICK})
IOS_XCODE(${IMAGEMAGICK_NAME} imagemagick)


IOSSIM_PATH(${IMAGEMAGICK}/${OS})
IOSSIM_COMMAND(${DKCMAKE_IOSSIM64} ${IMAGEMAGICK})
IOSSIM_XCODE(${IMAGEMAGICK_NAME} imagemagick)


LINUX_DEBUG_PATH(${IMAGEMAGICK}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${DKCMAKE_LINUX_DEBUG} ${IMAGEMAGICK})
LINUX_DEBUG_COMMAND(make imagemagick)

LINUX_RELEASE_PATH(${IMAGEMAGICK}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${DKCMAKE_LINUX_RELEASE} ${IMAGEMAGICK})
LINUX_RELEASE_COMMAND(make imagemagick)


ANDROID_NDK(${IMAGEMAGICK_NAME})
