# http://www.ijg.org/
# https://www.ijg.org/files/jpegsr9d.zip


### IMPORT ###
dk_import(https://www.ijg.org/files/jpegsr9d.zip)


### LINK ###
dk_include				(${JPEG})
dk_include				(${JPEG}/${OS})
dk_include				(${JPEG}/${OS}/${RELEASE_DIR})
ANDROID_dk_include		(${JPEG}/${OS}/${BUILD_TYPE}/jni)
WIN_dk_libDebug			(${JPEG}/${OS}/${DEBUG_DIR}/jpeg-static.lib)
WIN_dk_libRelease		(${JPEG}/${OS}/${RELEASE_DIR}/jpeg-static.lib)
APPLE_dk_libDebug		(${JPEG}/${OS}/${DEBUG_DIR}/libjpeg-static.a)
APPLE_dk_libRelease		(${JPEG}/${OS}/${RELEASE_DIR}/libjpeg-static.a)
LINUX_dk_libDebug		(${JPEG}/${OS}/${DEBUG_DIR}/libjpeg-static.a)
LINUX_dk_libRelease		(${JPEG}/${OS}/${RELEASE_DIR}/libjpeg-static.a)
ANDROID_dk_libDebug		(${JPEG}/${OS}/${DEBUG_DIR}/libjpeg-static.a)
ANDROID_dk_libRelease	(${JPEG}/${OS}/${RELEASE_DIR}/libjpeg-static.a)


### 3RDPARTY LINK ###
WIN_dk_set		(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS} -DJPEG_LIBRARY_DEBUG=${JPEG}/${OS}/${DEBUG_DIR}/jpeg-static.lib -DJPEG_LIBRARY_RELEASE=${JPEG}/${OS}/${RELEASE_DIR}/jpeg-static.lib)
APPLE_dk_set	(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE_DIR}/libjpeg-static.a)
LINUX_dk_set	(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE_DIR}/libjpeg-static.a)
RASPBERRY_dk_set(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS} -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE_DIR}/libjpeg-static.a)
ANDROID_dk_set	(JPEG_CMAKE -DJPEG_INCLUDE_DIR=${JPEG} -DJPEG_INCLUDE_DIR2=${JPEG}/${OS} -DJPEG_LIBRARY_DEBUG=${JPEG}/${OS}/${DEBUG_DIR}/jpeg-static.lib -DJPEG_LIBRARY_RELEASE=${JPEG}/${OS}/${RELEASE_DIR}/jpeg-static.lib)


### GENERATE ###
dk_setPath		(${JPEG}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} ${JPEG})


### COMPILE ###
dk_visualStudio	(${JPEG_NAME} jpeg-static) # windows, android
dk_xcode		(${JPEG_NAME} jpeg-static) # mac, ios, iossim
dk_make			(${JPEG_NAME} jpeg-static) # linux, raspberry