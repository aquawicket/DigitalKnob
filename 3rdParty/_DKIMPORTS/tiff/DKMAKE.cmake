# https://gitlab.com/libtiff/libtiff
# http://www.simplesystems.org/libtiff/
# https://download.osgeo.org/libtiff/
# https://gitlab.com/libtiff/libtiff/-/archive/v4.2.0/libtiff-v4.2.0.zip
# https://gitlab.com/libtiff/libtiff.git

### DEPEND ###
dk_depend(libjpeg-turbo)
#dk_depend(libwebp) ERROR: circular reference
dk_depend(xz)
dk_depend(zlib)
dk_depend(zstd)
#-- Could NOT find Deflate (missing: Deflate_LIBRARY Deflate_INCLUDE_DIR)
#-- Could NOT find JBIG (missing: JBIG_LIBRARY JBIG_INCLUDE_DIR)
#-- Could NOT find LERC (missing: LERC_LIBRARY LERC_INCLUDE_DIR)
#-- Could NOT find GLUT (missing: GLUT_glut_LIBRARY)


### IMPORT ###
dk_import(https://gitlab.com/libtiff/libtiff.git)


### LINK ###
dk_include					(${TIFF}/libtiff)
dk_include					(${TIFF}/${OS}/libtiff)
DEBUG_dk_include			(${TIFF}/${OS}/libtiff/${DEBUG_DIR})
RELEASE_dk_include			(${TIFF}/${OS}/libtiff/${RELEASE_DIR})
if(VISUAL_STUDIO_IDE)
	ANDROID_dk_libDebug		(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/libtiff.a)
	ANDROID_dk_libRelease	(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/libtiff.a)
	WIN_dk_libDebug			(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/tiffd.lib)
	WIN_dk_libRelease		(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/tiff.lib)
elseif(XCODE_IDE)
	dk_libDebug				(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/libtiff.a)
	dk_libRelease			(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/libtiff.a)
else()
	dk_libDebug				(${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a)
	dk_libRelease			(${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
endif()


### 3RDPARTY LINK ###
if(VISUAL_STUDIO_IDE)
	ANDROID_dk_set			(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff.a)
#else()
#	ANDROID_DEBUG_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/Debug/libtiff -I${TIFF}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/Debug/libtiff -I${TIFF}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${DEBUG_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
#	ANDROID_RELEASE_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
endif()
APPLE_dk_set				(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff.a)
EMSCRIPTEN_DEBUG_dk_set		(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${DEBUG_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
EMSCRIPTEN_RELEASE_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
LINUX_DEBUG_dk_set			(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${DEBUG_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
LINUX_RELEASE_dk_set		(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
RASPBERRY_DEBUG_dk_set		(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${DEBUG_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
RASPBERRY_RELEASE_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
WIN_dk_set					(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=/I${TIFF}/${OS}/libtiff" "-DCMAKE_CXX_FLAGS=/I${TIFF}/${OS}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/libtiff/${DEBUG_DIR}/tiffd.lib -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/libtiff/${RELEASE_DIR}/tiff.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} 
	${LIBJPEG-TURBO_CMAKE} 
	${XZ_CMAKE}
	${ZLIB_CMAKE}
	${ZSTD_CMAKE}
	${TIFF})


### COMPILE ###
dk_build(${TIFF} tiff)
