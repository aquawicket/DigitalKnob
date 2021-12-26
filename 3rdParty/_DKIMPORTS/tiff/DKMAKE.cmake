## https://download.osgeo.org/libtiff/

### VERSION ###
DKSET(TIFF_VERSION 4.0.3)
DKSET(TIFF_NAME tiff-${TIFF_VERSION})
DKSET(TIFF ${3RDPARTY}/${TIFF_NAME})


### INSTALL ###
## https://download.osgeo.org/libtiff/old/tiff-4.0.3.zip
DKINSTALL(https://download.osgeo.org/libtiff/old/${TIFF_NAME}.zip tiff ${TIFF})


### DKPLUGINS LINK ###
DKINCLUDE(${TIFF}/libtiff)
WIN_DEBUG_LIB(${TIFF}/${OS}/${DEBUG_DIR}/tiff-static.lib)
WIN_RELEASE_LIB(${TIFF}/${OS}/${RELEASE_DIR}/tiff-static.lib)
APPLE_DEBUG_LIB(${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a)
APPLE_RELEASE_LIB(${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
LINUX_DEBUG_LIB(${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a)
LINUX_RELEASE_LIB(${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
RASPBERRY_DEBUG_LIB(${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a)
RASPBERRY_RELEASE_LIB(${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
##ANDROID_DEBUG_LIB(${TIFF}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libtiff.a)
##ANDROID_RELEASE_LIB(${TIFF}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libtiff.a)
ANDROID_DEBUG_LIB(${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a)
ANDROID_RELEASE_LIB(${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)


### 3RDPARTY LINK ###
WIN_DKSET(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/tiff-static.lib -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/tiff-static.lib)
APPLE_DKSET(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
LINUX_DKSET(TIFF_CMAKE "-DCMAKE_C_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}" -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
RASPBERRY_DKSET(TIFF_CMAKE "-DCMAKE_C_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}" -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
ANDROID_DKSET(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
	

### COMPILE ###
DKSETPATH(${TIFF}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} ${TIFF})

WIN_VS(${TIFF_NAME} tiff.sln tiff-static)
MAC_XCODE(${TIFF_NAME} tiff-static)
IOS_XCODE(${TIFF_NAME} tiff-static)
IOSSIM_XCODE(${TIFF_NAME} tiff-static)
LINUX_DKQCOMMAND(make tiff-static)
RASPBERRY_DKQCOMMAND(make tiff-static)
ANDROID_VS(${TIFF_NAME} tiff.sln tiff-static)
