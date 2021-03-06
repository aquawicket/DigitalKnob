### VERSION ###
IF(ANDROID)
	DKSET(ZLIB_VERSION 1.2.8) ## https://www.zlib.net/fossils/zlib-1.2.8.tar.gz
ELSE()
	DKSET(ZLIB_VERSION 1.2.11) ##https://www.zlib.net/fossils/zlib-1.2.11.tar.gz
ENDIF()
DKSET(ZLIB_NAME zlib-${ZLIB_VERSION})
DKSET(ZLIB ${3RDPARTY}/${ZLIB_NAME})


### INSTALL ###
DKINSTALL(https://www.zlib.net/fossils/${ZLIB_NAME}.tar.gz zlib ${ZLIB_NAME})


### DKPLUGINS LINK ###
DKINCLUDE(${ZLIB})
DKINCLUDE(${ZLIB}/${OS})
WIN_DEBUG_LIB(${ZLIB}/${OS}/${DEBUG_DIR}/zlibstaticd.lib)
WIN_RELEASE_LIB(${ZLIB}/${OS}/${RELEASE_DIR}/zlibstatic.lib)
APPLE_DEBUG_LIB(${ZLIB}/${OS}/${DEBUG_DIR}/libz.a)
APPLE_RELEASE_LIB(${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
LINUX_DEBUG_LIB(${ZLIB}/${OS}/${DEBUG_DIR}/libz.a)
LINUX_RELEASE_LIB(${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
RASPBERRY_DEBUG_LIB(${ZLIB}/${OS}/${DEBUG_DIR}/libz.a)
RASPBERRY_RELEASE_LIB(${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
##ANDROID_DEBUG_LIB(${ZLIB}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libzlib.a)
##ANDROID_RELEASE_LIB(${ZLIB}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libzlib.a)
ANDROID_DEBUG_LIB(${ZLIB}/${OS}/${DEBUG_DIR}/libz.a)
ANDROID_RELEASE_LIB(${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)


### 3RDPARTY LINK ###
DKSET(ZLIB_WIN -DCMAKE_C_FLAGS=/I${ZLIB}/${OS} -DCMAKE_CXX_FLAGS=/I${ZLIB}/${OS} -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/zlibstatic.lib -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/zlibstatic.lib)
DKSET(ZLIB_APPLE -DCMAKE_C_FLAGS=-I${ZLIB}/${OS} -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
DKSET(ZLIB_LINUX "-DCMAKE_C_FLAGS=-I${ZLIB} -I${ZLIB}/${OS}/${RELEASE_DIR}" "-DCMAKE_CXX_FLAGS=-I${ZLIB} -I${ZLIB}/${OS}/${RELEASE_DIR}" -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
DKSET(ZLIB_RASPBERRY -DCMAKE_C_FLAGS=-I${ZLIB}/${OS}/${RELEASE_DIR} -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
DKSET(ZLIB_ANDROID "-DANDROID_COMPILER_FLAGS=-I${ZLIB}/${OS}/${DEBUG_DIR} -I${ZLIB}/${OS}/${RELEASE_DIR}" -DZLIB_INCLUDE_DIR=${ZLIB} -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)


### COMPILE ###
WIN_PATH(${ZLIB}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} ${ZLIB})
WIN64_COMMAND(${DKCMAKE_WIN64} ${ZLIB})
WIN_VS(${ZLIB_NAME} zlib.sln zlibstatic)


MAC_PATH(${ZLIB}/${OS})
MAC64_COMMAND(${DKCMAKE_MAC64} ${ZLIB})
MAC_XCODE(${ZLIB_NAME} zlibstatic)


IOS_PATH(${ZLIB}/${OS})
IOS64_COMMAND(${DKCMAKE_IOS64} ${ZLIB})
IOS_XCODE(${ZLIB_NAME} zlibstatic)


IOSSIM_PATH(${ZLIB}/${OS})
IOSSIM64_COMMAND(${DKCMAKE_IOSSIM64} ${ZLIB})
IOSSIM_XCODE(${ZLIB_NAME} zlibstatic)


LINUX_DEBUG_PATH(${ZLIB}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_C_FLAGS=-fPIC ${ZLIB})
LINUX_DEBUG_COMMAND(make zlibstatic)

LINUX_RELEASE_PATH(${ZLIB}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_C_FLAGS=-fPIC ${ZLIB})
LINUX_RELEASE_COMMAND(make zlibstatic)


RASPBERRY_DEBUG_PATH(${ZLIB}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_C_FLAGS=-fPIC ${ZLIB})
RASPBERRY_DEBUG_COMMAND(make zlibstatic)

RASPBERRY_RELEASE_PATH(${ZLIB}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_C_FLAGS=-fPIC ${ZLIB})
RASPBERRY_RELEASE_COMMAND(make zlibstatic)


##ANDROID_NDK(${ZLIB_NAME})

ANDROID_PATH(${ZLIB}/${OS})
ANDROID32_COMMAND(${DKCMAKE_ANDROID32} ${ZLIB})
ANDROID64_COMMAND(${DKCMAKE_ANDROID64} ${ZLIB})
ANDROID_VS(${ZLIB_NAME} zlib.sln zlibstatic)
