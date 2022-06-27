# http://www.ijg.org/
#
# https://www.ijg.org/files/jpegsr9d.zip


### VERSION ###
dk_set(JPEG_VERSION 9d)
dk_set(JPEG_NAME jpeg-${JPEG_VERSION})
dk_set(JPEG_DL http://www.ijg.org/files/jpegsr${JPEG_VERSION}.zip)
dk_set(JPEG ${3RDPARTY}/${JPEG_NAME})
#dk_install(${JPEG_DL} ${JPEG})
dk_import(${JPEG_DL} ${JPEG})



### LINK ###
dk_include(${JPEG})
dk_include(${JPEG}/${OS})
dk_include(${JPEG}/${OS}/${RELEASE_DIR})
ANDROID_dk_include(${JPEG}/${OS}/$(BUILD_TYPE)/jni)
WIN_dk_libDebug(${JPEG}/${OS}/${DEBUG_DIR}/jpeg-static.lib)
WIN_dk_libRelease(${JPEG}/${OS}/${RELEASE_DIR}/jpeg-static.lib)
APPLE_dk_libDebug(${JPEG}/${OS}/${DEBUG_DIR}/libjpeg-static.a)
APPLE_dk_libRelease(${JPEG}/${OS}/${RELEASE_DIR}/libjpeg-static.a)
LINUX_dk_libDebug(${JPEG}/${OS}/${DEBUG_DIR}/libjpeg-static.a)
LINUX_dk_libRelease(${JPEG}/${OS}/${RELEASE_DIR}/libjpeg-static.a)
ANDROID_dk_libDebug(${JPEG}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libjpeg.a)
ANDROID_dk_libRelease(${JPEG}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libjpeg.a)



### 3RDPARTY LINK ###
WIN_dk_set(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS} -DJPEG_LIBRARY_DEBUG=${JPEG}/${OS}/${DEBUG_DIR}/jpeg-static.lib -DJPEG_LIBRARY_RELEASE=${JPEG}/${OS}/${RELEASE_DIR}/jpeg-static.lib)
APPLE_dk_set(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE_DIR}/libjpeg-static.a)
LINUX_dk_set(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE_DIR}/libjpeg-static.a)
RASPBERRY_dk_set(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE_DIR}/libjpeg-static.a)



### COMPILE ###
dk_setPath(${JPEG}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${JPEG})


WIN_dk_visualStudio(${JPEG_NAME} jpeg.sln jpeg-static)
MAC_dk_xcode(${JPEG_NAME} jpeg-static)
IOS_dk_xcode(${JPEG_NAME} jpeg-static)
IOSSIM_dk_xcode(${JPEG_NAME} jpeg-static)
LINUX_dk_queueCommand(make jpeg-static)
ANDROID_dk_visualStudio(${JPEG_NAME} jpeg.sln jpeg-static)