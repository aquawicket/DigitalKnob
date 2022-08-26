# https://github.com/uNetworking/uWebSockets


dk_depend(zlib)
dk_depend(libuv)
dk_depend(openssl)

dk_import(https://github.com/uNetworking/uWebSockets.git BRANCH v0.14 PATCH)


### LINK ###
dk_include(${UWEBSOCKETS})
dk_include(${UWEBSOCKETS}/${OS})
WIN_dk_libDebug(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/uWS.lib)
WIN_dk_libRelease(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/uWS.lib)
APPLE_dk_libDebug(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/libuWS.a)
APPLE_dk_libRelease(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/libuWS.a)
LINUX_dk_libDebug(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/uWS.a)
LINUX_dk_libRelease(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/uWS.a)
RASPBERRY_dk_libDebug(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/uWS.a)
RASPBERRY_dk_libRelease(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/uWS.a)
##ANDROID_dk_libDebug(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/uWS.a)
##ANDROID_dk_libRelease(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/uWS.a)
ANDROID_dk_libDebug(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/uWS.a)
ANDROID_dk_libRelease(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/uWS.a)


### GENERATE ###
dk_setPath(${UWEBSOCKETS}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${ZLIB_CMAKE} ${LIBUV_CMAKE} ${OPENSSL_CMAKE} ${UWEBSOCKETS})


### COMPILE ###
dk_visualStudio(${UWEBSOCKETS_NAME} uWS)
dk_xcode(${UWEBSOCKETS_NAME} uWS)
LINUX_dk_queueCommand(make uWebSockets)
RASPBERRY_dk_queueCommand(make uWebSockets)
