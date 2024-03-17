# https://libwebsockets.org
# https://github.com/warmcat/libwebsockets
# https://github.com/warmcat/libwebsockets/archive/v2.2.0.zip


### DEPEND ###
#dk_depend(openssl)


### IMPORT ###
dk_import(https://github.com/warmcat/libwebsockets.git BRANCH main)


### LINK ###
dk_include			(${LIBWEBSOCKETS}/lib)
dk_include			(${LIBWEBSOCKETS}/${OS})
UNIX_dk_libDebug	(${LIBWEBSOCKETS}/${OS}/${DEBUG_DIR}/lib/libwebsockets.a)
UNIX_dk_libRelease	(${LIBWEBSOCKETS}/${OS}/${RELEASE_DIR}/lib/libwebsockets.a)
WIN_dk_libDebug		(${LIBWEBSOCKETS}/${OS}/lib/${DEBUG_DIR}/websockets_static.lib)
WIN_dk_libRelease	(${LIBWEBSOCKETS}/${OS}/lib/${RELEASE_DIR}/websockets_static.lib)


### GENERATE ###
dk_configure(${LIBWEBSOCKETS} -DLWS_WITH_SSL=OFF)


### COMPILE ###
dk_build(${LIBWEBSOCKETS} websockets)
