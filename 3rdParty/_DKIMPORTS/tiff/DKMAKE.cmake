# https://gitlab.com/libtiff/libtiff
# http://www.simplesystems.org/libtiff/
# https://download.osgeo.org/libtiff/

#DKSET(TIFF_DL https://download.osgeo.org/libtiff/old/tiff-4.0.3.zip PATCH)


DKIMPORT(https://gitlab.com/libtiff/libtiff.git)

#DKSET(TIFF_VERSION 4.2.0)
#DKSET(TIFF_DL https://gitlab.com/libtiff/libtiff/-/archive/v4.2.0/libtiff-v4.2.0.zip)
#DKSET(TIFF_NAME tiff-${TIFF_VERSION})
#DKSET(TIFF ${3RDPARTY}/${TIFF_NAME})
#DKINSTALL(${TIFF_DL} tiff ${TIFF})


### DKPLUGINS LINK ###
DKINCLUDE(${TIFF}/libtiff)
DEBUG_DKINCLUDE(${TIFF}/${OS}/${DEBUG_DIR}/libtiff)
RELEASE_DKINCLUDE(${TIFF}/${OS}/${RELEASE_DIR}/libtiff)
#RASPBERRY_RELEASE_DKLIB(${TIFF}/${OS}/${RELEASE_DIR}/
WIN_DEBUG_DKLIB(${TIFF}/${OS}/${DEBUG_DIR}/tiff-static.lib)
WIN_RELEASE_DKLIB(${TIFF}/${OS}/${RELEASE_DIR}/tiff-static.lib)
APPLE_DEBUG_DKLIB(${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a)
APPLE_RELEASE_DKLIB(${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
#LINUX_DEBUG_DKLIB(${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a)
#LINUX_RELEASE_DKLIB(${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
LINUX_DEBUG_DKLIB(${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a)
LINUX_RELEASE_DKLIB(${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
#RASPBERRY_DEBUG_DKLIB(${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a)
#RASPBERRY_RELEASE_DKLIB(${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
RASPBERRY_DEBUG_DKLIB(${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a)
RASPBERRY_RELEASE_DKLIB(${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
ANDROID_DEBUG_DKLIB(${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a)
ANDROID_RELEASE_DKLIB(${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)


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
LINUX_DKQCOMMAND(make) #tiff-static)
RASPBERRY_DKQCOMMAND(make) #tiff-static)
ANDROID_VS(${TIFF_NAME} tiff.sln tiff-static)
