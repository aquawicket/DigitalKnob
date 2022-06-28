# https://www.gnu.org/software/libiconv/
# https://savannah.gnu.org/projects/libiconv
# https://stackoverflow.com/a/57734435/688352


dk_install(https://ftp.gnu.org/gnu/libiconv/libiconv-1.14.tar.gz ${3RDPARTY}/libiconv-1.14 PATCH)
#dk_import(https://ftp.gnu.org/gnu/libiconv/libiconv-1.14.tar.gz ${3RDPARTY}/libiconv-1.14 PATCH)


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
#APPLE_dk_libDebug		(${LIBICONV}/${OS}/${DEBUG_DIR}/libiconv.a)
#APPLE_dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/libiconv.a)
#APPLE_dk_libDebug		(${LIBICONV}/${OS}/${DEBUG_DIR}/libcharset.a)
#APPLE_dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/libcharset.a)
#LINUX_dk_libDebug		(${LIBICONV}/${OS}/${DEBUG_DIR}/libiconv.a)
#LINUX_dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/libiconv.a)
#LINUX_dk_libDebug		(${LIBICONV}/${OS}/${DEBUG_DIR}/libcharset.a)
#LINUX_dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/libcharset.a)
#RASPBERRY_dk_libDebug	(${LIBICONV}/${OS}/${DEBUG_DIR}/libiconv.a)
#RASPBERRY_dk_libRelease	(${LIBICONV}/${OS}/${RELEASE_DIR}/libiconv.a)
#RASPBERRY_dk_libDebug	(${LIBICONV}/${OS}/${DEBUG_DIR}/libcharset.a)
#RASPBERRY_dk_libRelease	(${LIBICONV}/${OS}/${RELEASE_DIR}/libcharset.a)
#ANDROID_dk_libDebug		(${LIBICONV}/${OS}/${DEBUG_DIR}/libiconv.a)
#ANDROID_dk_libRelease	(${LIBICONV}/${OS}/${RELEASE_DIR}/libiconv.a)
#ANDROID_dk_libDebug		(${LIBICONV}/${OS}/${DEBUG_DIR}/libcharset.a)
#ANDROID_dk_libRelease	(${LIBICONV}/${OS}/${RELEASE_DIR}/libcharset.a)



WIN_dk_set(LIBICONV_CMAKE -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include)
APPLE_dk_set(LIBICONV_CMAKE "-DCMAKE_C_FLAGS=-I${LIBICONV}/include" -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include)
LINUX_dk_set(LIBICONV_CMAKE -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include)
RASPBERRY_dk_set(LIBICONV_CMAKE -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include)
ANDROID_dk_set(LIBICONV_CMAKE -DICONV_DIR=${LIBICONV} -DICONV_LIBRARIES=${LIBICONV}/${OS}/${RELEASE_DIR} -DICONV_INCLUDE_DIR=${LIBICONV}/include)


### GENERATE ###
dk_setPath(${LIBICONV}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${LIBICONV})


### COMPILE ###
#WIN_dk_visualStudio(${LIBICONV_NAME} libiconv.sln iconv)
dk_visualStudio(${LIBICONV_NAME} libiconv.sln iconv)
#MAC_dk_xcode(${LIBICONV_NAME} iconv)
#IOS_dk_xcode(${LIBICONV_NAME} iconv)
#IOSSIM_dk_xcode(${LIBICONV_NAME} iconv)
dk_xcode(${LIBICONV_NAME} iconv)
LINUX_dk_queueCommand(make iconv)
RASPBERRY_dk_queueCommand(make iconv)
#ANDROID_dk_visualStudio(${LIBICONV_NAME} libiconv.sln iconv)
