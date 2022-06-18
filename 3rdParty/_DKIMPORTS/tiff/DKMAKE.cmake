# https://gitlab.com/libtiff/libtiff
# http://www.simplesystems.org/libtiff/
# https://download.osgeo.org/libtiff/


dk_import(https://gitlab.com/libtiff/libtiff.git)
#dk_import(https://gitlab.com/libtiff/libtiff/-/archive/v4.2.0/libtiff-v4.2.0.zip)

#dk_set(TIFF_VERSION 4.2.0)
#dk_set(TIFF_DL https://gitlab.com/libtiff/libtiff/-/archive/v4.2.0/libtiff-v4.2.0.zip)
#dk_set(TIFF_NAME tiff-${TIFF_VERSION})
#dk_set(TIFF ${3RDPARTY}/${TIFF_NAME})
#dk_install(${TIFF_DL} tiff ${TIFF})


### DKPLUGINS LINK ###
dk_include(${TIFF}/libtiff)
DEBUG_dk_include(${TIFF}/${OS}/${DEBUG_DIR}/libtiff)
RELEASE_dk_include(${TIFF}/${OS}/${RELEASE_DIR}/libtiff)
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
WIN_dk_set(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/tiff-static.lib -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/tiff-static.lib)
APPLE_dk_set(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
LINUX_dk_set(TIFF_CMAKE "-DCMAKE_C_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}" -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
RASPBERRY_dk_set(TIFF_CMAKE "-DCMAKE_C_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}" -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
ANDROID_dk_set(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
	

### COMPILE ###
dk_setPath(${TIFF}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${TIFF})

WIN_VS(${TIFF_NAME} tiff.sln tiff-static)
MAC_XCODE(${TIFF_NAME} tiff-static)
IOS_XCODE(${TIFF_NAME} tiff-static)
IOSSIM_XCODE(${TIFF_NAME} tiff-static)
LINUX_dk_queueCommand(make) #tiff-static)
RASPBERRY_dk_queueCommand(make) #tiff-static)
ANDROID_VS(${TIFF_NAME} tiff.sln tiff-static)
