# https://gitlab.com/libtiff/libtiff
# http://www.simplesystems.org/libtiff/
# https://download.osgeo.org/libtiff/
# https://gitlab.com/libtiff/libtiff/-/archive/v4.2.0/libtiff-v4.2.0.zip
# https://gitlab.com/libtiff/libtiff.git


dk_import(https://gitlab.com/libtiff/libtiff.git)


### DKPLUGINS LINK ###
dk_include				(${TIFF}/libtiff)
DEBUG_dk_include		(${TIFF}/${OS}/${DEBUG_DIR}/libtiff)
RELEASE_dk_include		(${TIFF}/${OS}/${RELEASE_DIR}/libtiff)
WIN_dk_libDebug			(${TIFF}/${OS}/${DEBUG_DIR}/tiff-static.lib)
WIN_dk_libRelease		(${TIFF}/${OS}/${RELEASE_DIR}/tiff-static.lib)
APPLE_dk_libDebug		(${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a)
APPLE_dk_libRelease		(${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
LINUX_dk_libDebug		(${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a)
LINUX_dk_libRelease		(${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
RASPBERRY_dk_libDebug	(${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a)
RASPBERRY_dk_libRelease	(${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
ANDROID_dk_libDebug		(${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a)
ANDROID_dk_libRelease	(${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)


### 3RDPARTY LINK ###
WIN_dk_set		(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/tiff-static.lib -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/tiff-static.lib)
APPLE_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
LINUX_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a "-DCMAKE_C_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}")
RASPBERRY_dk_set(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a "-DCMAKE_C_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS_DEBUG=-I${TIFF}/${OS}/${DEBUG_DIR}")
ANDROID_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff -DTIFF_INCLUDE_DIR2=${TIFF}/${OS} -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff-static.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff-static.a)
	

### GENERATE ###
dk_setPath		(${TIFF}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} ${TIFF})


### COMPILE ###
dk_visualStudio				(${TIFF_NAME} tiff-static)
dk_xcode					(${TIFF_NAME} tiff-static)
LINUX_dk_queueCommand		(make) #tiff-static)
RASPBERRY_dk_queueCommand	(make) #tiff-static)
