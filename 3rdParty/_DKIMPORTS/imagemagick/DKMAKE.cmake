# https://imagemagick.org/index.php
# https://github.com/ImageMagick/ImageMagick


### DEPENDS ###
#dk_depend(ghostscript)

#dk_import(https://github.com/ImageMagick/ImageMagick)
if(WIN)
	dk_set(IMAGEMAGICK_VERSION 7.1.0-portable-Q16-x86)
else()
	dk_set(IMAGEMAGICK_VERSION 7.1.0-0)
endif()
dk_set(IMAGEMAGICK_NAME ImageMagick-${IMAGEMAGICK_VERSION})
WIN_dk_set(IMAGEMAGICK_DL http://ftp.icm.edu.pl/packages/ImageMagick/binaries/ImageMagick-7.1.0-portable-Q16-x86.zip)
LINUX_dk_set(IMAGEMAGICK_DL https://github.com/ImageMagick/ImageMagick/archive/refs/tags/7.1.0-0.zip)
MAC_dk_set(IMAGEMAGICK_DL https://github.com/ImageMagick/ImageMagick/archive/refs/tags/7.1.0-0.zip)
dk_set(IMAGEMAGICK ${3RDPARTY}/${IMAGEMAGICK_NAME})
dk_import(${IMAGEMAGICK_DL} ${IMAGEMAGICK})


WIN_dk_set(IMAGEMAGICK_CONVERT ${IMAGEMAGICK}/convert.exe)


### LINK ###
#dk_include(${IMAGEMAGICK}/${OS})
#WIN_dk_libDebug(${IMAGEMAGICK}/${OS}/${DEBUG_DIR}/imagemagickd.lib)
#WIN_dk_libRelease(${IMAGEMAGICK}/${OS}/${RELEASE_DIR}/imagemagick.lib)
APPLE_dk_libDebug(${IMAGEMAGICK}/${OS}/${DEBUG_DIR}/libimagemagick.a)
APPLE_dk_libRelease(${IMAGEMAGICK}/${OS}/${RELEASE_DIR}/libimagemagick.a)
LINUX_dk_libDebug(${IMAGEMAGICK}/${OS}/${DEBUG_DIR}/libimagemagick.a)
LINUX_dk_libRelease(${IMAGEMAGICK}/${OS}/${RELEASE_DIR}/libimagemagick.a)
ANDROID_dk_libDebug(${IMAGEMAGICK}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libimagemagick.a)
ANDROID_dk_libRelease(${IMAGEMAGICK}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libimagemagick.a)


### COMPILE ###
WIN32_DEBUG_dk_setPath(${IMAGEMAGICK}/${OS}/${DEBUG_DIR})
WIN32_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
WIN32_DEBUG_dk_msys(make)
WIN32_RELEASE_dk_setPath(${IMAGEMAGICK}/${OS}/${RELEASE_DIR})
WIN32_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
WIN32_RELEASE_dk_msys(make)


WIN64_DEBUG_dk_setPath(${IMAGEMAGICK}/${OS}/${DEBUG_DIR})
WIN64_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
WIN64_DEBUG_dk_msys(make)
WIN64_RELEASE_dk_setPath(${IMAGEMAGICK}/${OS}/${RELEASE_DIR})
WIN64_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
WIN64_RELEASE_dk_msys(make)


MAC_DEBUG_dk_setPath(${IMAGEMAGICK}/${OS}/${DEBUG_DIR})
MAC_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_DEBUG_dk_queueCommand(make)
MAC_RELEASE_dk_setPath(${IMAGEMAGICK}/${OS}/${RELEASE_DIR})
MAC_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_RELEASE_dk_queueCommand(make)


IOS_DEBUG_dk_setPath(${IMAGEMAGICK}/${OS}/${DEBUG_DIR})
IOS_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOS_DEBUG_dk_queueCommand(make)
IOS_RELEASE_dk_setPath(${IMAGEMAGICK}/${OS}/${RELEASE_DIR})
IOS_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOS_RELEASE_dk_queueCommand(make)


IOSSIM_DEBUG_dk_setPath(${IMAGEMAGICK}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOSSIM_DEBUG_dk_queueCommand(make)
IOSSIM_RELEASE_dk_setPath(${IMAGEMAGICK}/${OS}/${RELEASE_DIR})
IOSSIM_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOSSIM_RELEASE_dk_queueCommand(make)


LINUX_DEBUG_dk_setPath(${IMAGEMAGICK}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_DEBUG_dk_queueCommand(make)
LINUX_RELEASE_dk_setPath(${IMAGEMAGICK}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_RELEASE_dk_queueCommand(make)


RASPBERRY_DEBUG_dk_setPath(${IMAGEMAGICK}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_DEBUG_dk_queueCommand(make)
RASPBERRY_RELEASE_dk_setPath(${IMAGEMAGICK}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_RELEASE_dk_queueCommand(make)


ANDROID_DEBUG_dk_setPath(${IMAGEMAGICK}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
ANDROID_DEBUG_dk_msys(make)
ANDROID_RELEASE_dk_setPath(${IMAGEMAGICK}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
ANDROID_RELEASE_dk_msys(make)
