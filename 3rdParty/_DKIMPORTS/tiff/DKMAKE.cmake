# https://gitlab.com/libtiff/libtiff
# http://www.simplesystems.org/libtiff/
# https://download.osgeo.org/libtiff/
# https://gitlab.com/libtiff/libtiff/-/archive/v4.2.0/libtiff-v4.2.0.zip
# https://gitlab.com/libtiff/libtiff.git


dk_import(https://gitlab.com/libtiff/libtiff.git)


### DKPLUGINS LINK ###
dk_include				(${TIFF}/libtiff)
dk_include				(${TIFF}/${OS}/libtiff)
DEBUG_dk_include		(${TIFF}/${OS}/libtiff/${DEBUG_DIR})
RELEASE_dk_include		(${TIFF}/${OS}/libtiff/${RELEASE_DIR})

WIN_dk_libDebug			(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/tiffd.lib)
WIN_dk_libRelease		(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/tiff.lib)
APPLE_dk_libDebug		(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/libtiff.a)
APPLE_dk_libRelease		(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/libtiff.a)
LINUX_dk_libDebug		(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/libtiff/libtiff.a)
LINUX_dk_libRelease		(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/libtiff/libtiff.a)
RASPBERRY_dk_libDebug	(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/libtiff/libtiff.a)
RASPBERRY_dk_libRelease	(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/libtiff/libtiff.a)
ANDROID_dk_libDebug		(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/libtiff.a)
ANDROID_dk_libRelease	(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/libtiff.a)


### 3RDPARTY LINK ###
WIN_dk_set		(TIFF_CMAKE "-DCMAKE_CXX_FLAGS=-I${TIFF}/libtiff" -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/libtiff/${DEBUG_DIR}/tiffd.lib -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/libtiff/${RELEASE_DIR}/tiff.lib)
APPLE_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff.a)
LINUX_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff.a "-DCMAKE_C_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}")
RASPBERRY_dk_set(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff.a "-DCMAKE_C_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}")
ANDROID_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff.a)
	

### GENERATE ###
dk_setPath		(${TIFF}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} ${TIFF})


### COMPILE ###
dk_visualStudio				(${TIFF_NAME} tiff) # tiff-static)
dk_xcode					(${TIFF_NAME} tiff) # tiff-static)
LINUX_dk_queueCommand		(make) #tiff-static)
RASPBERRY_dk_queueCommand	(make) #tiff-static)
