# https://www.gnu.org/software/libiconv/
# https://savannah.gnu.org/projects/libiconv
# https://stackoverflow.com/a/57734435/688352


dk_import(https://ftp.gnu.org/gnu/libiconv/libiconv-1.14.tar.gz PATCH)


### LINK ###
dk_include				(${LIBICONV})
dk_include				(${LIBICONV}/include)
dk_include				(${LIBICONV}/${OS})
dk_include				(${LIBICONV}/${OS}/${RELEASE_DIR})
ANDROID_dk_include		(${LIBICONV}/${OS}/$(BUILD_TYPE)/jni)

WIN_dk_libDebug			(${LIBICONV}/${OS}/${DEBUG_DIR}/iconv.lib)
WIN_dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/iconv.lib)
WIN_dk_libDebug			(${LIBICONV}/${OS}/${DEBUG_DIR}/charset.lib)
WIN_dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/charset.lib)
UNIX_dk_libDebug		(${LIBICONV}/${OS}/${DEBUG_DIR}/libiconv.a)
UNIX_dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/libiconv.a)
UNIX_dk_libDebug		(${LIBICONV}/${OS}/${DEBUG_DIR}/libcharset.a)
UNIX_dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/libcharset.a)


### 3RDPARTY LINK ###
WIN_dk_set			(LIBICONV_CMAKE -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DIconv_LIBRARY=${LIBICONV}/${OS}/${RELEASE_DIR}/iconv.lib -DIconv_INCLUDE_DIR=${LIBICONV}/include -DICONV_INCLUDE_DIR=${LIBICONV}/include)
APPLE_dk_set		(LIBICONV_CMAKE -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include "-DCMAKE_C_FLAGS=-I${LIBICONV}/include" )
LINUX_dk_set		(LIBICONV_CMAKE -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include)
RASPBERRY_dk_set	(LIBICONV_CMAKE -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include)
ANDROID_dk_set		(LIBICONV_CMAKE -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include)
EMSCRIPTEN_dk_set	(LIBICONV_CMAKE -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include)


### GENERATE ###
dk_queueCommand	(${DKCMAKE_BUILD} ${LIBICONV})


### COMPILE ###
dk_build(${LIBICONV_FOLDER} iconv)
