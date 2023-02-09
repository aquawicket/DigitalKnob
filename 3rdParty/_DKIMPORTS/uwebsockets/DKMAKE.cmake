# https://github.com/uNetworking/uWebSockets


### DEPEND ###
dk_depend(libuv)
dk_depend(openssl)
dk_depend(zlib)


### IMPORT ###
#dk_import(https://github.com/uNetworking/uWebSockets.git BRANCH v0.14 PATCH)
dk_import(https://github.com/uNetworking/uWebSockets/archive/refs/tags/v0.14.0.zip PATCH)
#dk_import(https://github.com/uNetworking/uWebSockets/archive/refs/tags/v0.14.1.zip PATCH)


### LINK ###
dk_include			(${UWEBSOCKETS})
dk_include			(${UWEBSOCKETS}/${OS})
UNIX_dk_libDebug	(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/libuWS.a)
UNIX_dk_libRelease	(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/libuWS.a)
WIN_dk_libDebug		(${UWEBSOCKETS}/${OS}/${DEBUG_DIR}/uWS.lib)
WIN_dk_libRelease	(${UWEBSOCKETS}/${OS}/${RELEASE_DIR}/uWS.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} 
	${LIBUV_CMAKE}
	${OPENSSL_CMAKE}
	${ZLIB_CMAKE}
	${UWEBSOCKETS})


### COMPILE ###
dk_build(${UWEBSOCKETS} uWS)
