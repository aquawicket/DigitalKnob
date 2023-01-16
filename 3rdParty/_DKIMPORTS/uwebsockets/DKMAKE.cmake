# https://github.com/uNetworking/uWebSockets


### DEPEND ###
dk_depend(zlib)
dk_depend(libuv)
dk_depend(openssl)


### IMPORT ###
dk_import(https://github.com/uNetworking/uWebSockets.git BRANCH v0.14 PATCH)


### LINK ###
dk_include				(${UWEBSOCKETS})
dk_include				(${UWEBSOCKETS}/${OS})
WIN_dk_libDebug			(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/uWS.lib)
WIN_dk_libRelease		(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/uWS.lib)
APPLE_dk_libDebug		(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/libuWS.a)
APPLE_dk_libRelease		(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/libuWS.a)
LINUX_dk_libDebug		(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/libuWS.a)
LINUX_dk_libRelease		(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/libuWS.a)
RASPBERRY_dk_libDebug	(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/libuWS.a)
RASPBERRY_dk_libRelease	(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/libuWS.a)
ANDROID_dk_libDebug		(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/libuWS.a)
ANDROID_dk_libRelease	(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/libuWS.a)


### GENERATE ###
dk_queueCommand	(${DKCMAKE_BUILD} ${ZLIB_CMAKE} ${LIBUV_CMAKE} ${OPENSSL_CMAKE} ${UWEBSOCKETS})


### COMPILE ###
dk_build(${UWEBSOCKETS} uWS)
