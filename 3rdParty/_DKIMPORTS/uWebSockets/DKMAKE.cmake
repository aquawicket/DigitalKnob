DKDEPEND(zlib)
DKDEPEND(libuv)
##DKDEPEND(openssl)


### VERSION ###
DKSET(UWEBSOCKETS_MAJOR_VERSION 0)
DKSET(UWEBSOCKETS_MINOR_VERSION 14)
DKSET(UWEBSOCKETS_VERSION ${UWEBSOCKETS_MAJOR_VERSION}.${UWEBSOCKETS_MINOR_VERSION})
DKSET(UWEBSOCKETS_NAME uWebSockets-${UWEBSOCKETS_VERSION})
DKSET(UWEBSOCKETS ${3RDPARTY}/${UWEBSOCKETS_NAME})



### INSTALL ###
## https://github.com/uNetworking/uWebSockets/archive/v0.14.zip
DKINSTALL(https://github.com/uNetworking/uWebSockets/archive/v${UWEBSOCKETS_VERSION}.zip uWebSockets ${UWEBSOCKETS_NAME})
DKRENAME(${DKDOWNLOAD}/v${UWEBSOCKETS_VERSION}.zip ${DKDOWNLOAD}/${UWEBSOCKETS_NAME}.zip)



### LINK ###
DKINCLUDE(${UWEBSOCKETS})
DKINCLUDE(${UWEBSOCKETS}/${OS})
WIN_DEBUG_LIB(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/uWS.lib)
WIN_RELEASE_LIB(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/uWS.lib)
MAC_DEBUG_LIB(${UWEBSOCKETS}/${OS}/lib/${DEBUG_DIR}/uWS.a)
MAC_RELEASE_LIB(${UWEBSOCKETS}/${OS}/lib/${RELEASE_DIR}/uWS.a)
IOSSIM_DEBUG_LIB(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/lib/.libs/uWS.a)
IOSSIM_RELEASE_LIB(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/lib/.libs/uWS.a)
LINUX_DEBUG_LIB(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/uWS.a)
LINUX_RELEASE_LIB(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/uWS.a)
RASPBERRY_DEBUG_LIB(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/uWS.a)
RASPBERRY_RELEASE_LIB(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/uWS.a)
##ANDROID_DEBUG_LIB(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/uWS.a)
##ANDROID_RELEASE_LIB(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/uWS.a)
ANDROID_DEBUG_LIB(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/uWS.a)
ANDROID_RELEASE_LIB(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/uWS.a)



### COMPILE ###
WIN_PATH(${UWEBSOCKETS}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /I${ZLIB}/${OS}" ${ZLIB_WIN} ${LIBUV_WIN} ${OPENSSL_WIN} ${UWEBSOCKETS})
WIN64_COMMAND(${DKCMAKE_WIN64} "-DCMAKE_CXX_FLAGS=/DWIN64 /D_WINDOWS /W3 /nologo /I${ZLIB}/${OS}" ${ZLIB_WIN} ${LIBUV_WIN} ${OPENSSL_WIN} ${UWEBSOCKETS})
WIN_VS(${UWEBSOCKETS_NAME} µWebSockets.sln uWS)


MAC_PATH(${UWEBSOCKETS}/${OS})
MAC64_COMMAND(${DKCMAKE_MAC64} ${UWEBSOCKETS})
MAC64_XCODE(${UWEBSOCKETS_NAME} libuWS)


IOS_PATH(${UWEBSOCKETS}/${OS})
IOS_COMMAND(${DKCMAKE_IOS64} ${UWEBSOCKETS})
IOS_XCODE(${UWEBSOCKETS_NAME} libuWS)


IOSSIM_PATH(${UWEBSOCKETS}/${OS})
IOSSIM_COMMAND(${DKCMAKE_IOSSIM64} ${UWEBSOCKETS})
IOSSIM_XCODE(${UWEBSOCKETS_NAME} libuWS)


LINUX_DEBUG_PATH(${UWEBSOCKETS}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_C_FLAGS=-fPIC ${UWEBSOCKETS})
LINUX_DEBUG_COMMAND(make uWebSockets)

LINUX_RELEASE_PATH(${UWEBSOCKETS}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_C_FLAGS=-fPIC ${UWEBSOCKETS})
LINUX_RELEASE_COMMAND(make uWebSockets)


RASPBERRY_DEBUG_PATH(${UWEBSOCKETS}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_C_FLAGS=-fPIC ${UWEBSOCKETS})
RASPBERRY_DEBUG_COMMAND(make uWebSockets)

RASPBERRY_RELEASE_PATH(${UWEBSOCKETS}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_C_FLAGS=-fPIC ${UWEBSOCKETS})
RASPBERRY_RELEASE_COMMAND(make uWebSockets)


##ANDROID_NDK(${UWEBSOCKETS_NAME})

ANDROID_PATH(${UWEBSOCKETS}/${OS})
ANDROID32_COMMAND(${DKCMAKE_WIN32} "-DANDROID_COMPILER_FLAGS=-DANDROID32 -D_ANDROID -I${ZLIB}/${OS}" ${ZLIB_ANDROID} ${LIBUV_ANDROID} ${OPENSSL_ANDROID} ${UWEBSOCKETS})
ANDROID64_COMMAND(${DKCMAKE_WIN64} "-DANDROID_COMPILER_FLAGS=-DANDROID64 -D_ANDROID -I${ZLIB}/${OS}" ${ZLIB_ANDROID} ${LIBUV_ANDROID} ${OPENSSL_ANDROID} ${UWEBSOCKETS})
ANDROID_VS(${UWEBSOCKETS_NAME} µWebSockets.sln uWS)
