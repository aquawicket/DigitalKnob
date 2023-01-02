# https://gitlab.com/libtiff/libtiff
# http://www.simplesystems.org/libtiff/
# https://download.osgeo.org/libtiff/
# https://gitlab.com/libtiff/libtiff/-/archive/v4.2.0/libtiff-v4.2.0.zip
# https://gitlab.com/libtiff/libtiff.git

### DEPEND ###
dk_depend(libjpeg-turbo)
#dk_depend(libwebp) ERROR: circular reference 
dk_depend(zlib)
dk_depend(zstd)


### IMPORT ###
dk_import(https://gitlab.com/libtiff/libtiff.git)


### LINK ###
dk_include				(${TIFF}/libtiff)
dk_include				(${TIFF}/${OS}/libtiff)
DEBUG_dk_include		(${TIFF}/${OS}/libtiff/${DEBUG_DIR})
RELEASE_dk_include		(${TIFF}/${OS}/libtiff/${RELEASE_DIR})
if(VISUAL_STUDIO_IDE)
	WIN_dk_libDebug			(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/tiffd.lib)
	WIN_dk_libRelease		(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/tiff.lib)
	ANDROID_dk_libDebug		(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/libtiff.a)
	ANDROID_dk_libRelease	(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/libtiff.a)
elseif(XCODE_IDE)
	dk_libDebug				(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/libtiff.a)
	dk_libRelease			(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/libtiff.a)
else()
	dk_libDebug				(${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a)
	dk_libRelease			(${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
endif()


### 3RDPARTY LINK ###
WIN_dk_set				(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=/I${TIFF}/${OS}/libtiff" "-DCMAKE_CXX_FLAGS=/I${TIFF}/${OS}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/libtiff/${DEBUG_DIR}/tiffd.lib -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/libtiff/${RELEASE_DIR}/tiff.lib)
APPLE_dk_set			(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff.a)
LINUX_DEBUG_dk_set		(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${DEBUG_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
LINUX_RELEASE_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
RASPBERRY_DEBUG_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${DEBUG_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
RASPBERRY_RELEASE_dk_set(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
if(VISUAL_STUDIO_IDE)
	ANDROID_dk_set			(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff.a)
#else()
#	ANDROID_DEBUG_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/Debug/libtiff -I${TIFF}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/Debug/libtiff -I${TIFF}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${DEBUG_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
#	ANDROID_RELEASE_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
endif()
EMSCRIPTEN_DEBUG_dk_set		(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${DEBUG_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)
EMSCRIPTEN_RELEASE_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR}/libtiff -DTIFF_LIBRARY_DEBUG=${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a -DTIFF_LIBRARY_RELEASE=${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a)



### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${TIFF})


### COMPILE ###
dk_build(${TIFF_FOLDER} tiff)
