# https://www.gnu.org/software/libiconv/
# https://savannah.gnu.org/projects/libiconv
# https://stackoverflow.com/a/57734435/688352


### IMPORT ###
dk_import(http://ftp.vim.org/ftp/gnu/libiconv/libiconv-1.14.tar.gz PATCH)
#dk_import(https://ftp.gnu.org/gnu/libiconv/libiconv-1.14.tar.gz PATCH)


### LINK ###
dk_include				(${LIBICONV})
dk_include				(${LIBICONV}/include)
dk_include				(${LIBICONV}/${OS})
dk_include				(${LIBICONV}/${OS}/${RELEASE_DIR})
ANDROID_dk_include		(${LIBICONV}/${OS}/$(BUILD_TYPE)/jni)

# libcharset
UNIX_dk_libDebug		(${LIBICONV}/${OS}/${DEBUG_DIR}/libcharset.a)
UNIX_dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/libcharset.a)
WIN_dk_libDebug			(${LIBICONV}/${OS}/${DEBUG_DIR}/charset.lib)
WIN_dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/charset.lib)

#libiconv
UNIX_dk_libDebug		(${LIBICONV}/${OS}/${DEBUG_DIR}/libiconv.a)
UNIX_dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/libiconv.a)
WIN_dk_libDebug			(${LIBICONV}/${OS}/${DEBUG_DIR}/iconv.lib)
WIN_dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/iconv.lib)


### 3RDPARTY LINK ###
ANDROID_dk_set		(LIBICONV_CMAKE -DLIBICONV_PATH=${LIBICONV} -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include)
APPLE_dk_set		(LIBICONV_CMAKE -DLIBICONV_PATH=${LIBICONV} -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include "-DCMAKE_C_FLAGS=-I${LIBICONV}/include" )
EMSCRIPTEN_dk_set	(LIBICONV_CMAKE -DLIBICONV_PATH=${LIBICONV} -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include)
LINUX_dk_set		(LIBICONV_CMAKE -DLIBICONV_PATH=${LIBICONV} -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include)
RASPBERRY_dk_set	(LIBICONV_CMAKE -DLIBICONV_PATH=${LIBICONV} -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include)
WIN_dk_set			(LIBICONV_CMAKE -DLIBICONV_PATH=${LIBICONV} -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DIconv_LIBRARY=${LIBICONV}/${OS}/${RELEASE_DIR}/iconv.lib -DIconv_INCLUDE_DIR=${LIBICONV}/include -DICONV_INCLUDE_DIR=${LIBICONV}/include)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${LIBICONV})


### COMPILE ###
dk_build(${LIBICONV} iconv)
