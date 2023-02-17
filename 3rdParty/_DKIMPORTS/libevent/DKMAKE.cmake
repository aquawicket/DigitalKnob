# https://github.com/libevent/libevent.git


### DEPEND ###
dk_depend(mbedtls)
dk_depend(openssl)


### IMPORT ###
dk_import(https://github.com/libevent/libevent.git)


### LINK ###
dk_include			(${LIBEVENT}/include)
UNIX_dk_libDebug	(${LIBEVENT}/${OS}/${DEBUG_DIR}/libevent.a)
UNIX_dk_libRelease	(${LIBEVENT}/${OS}/${RELEASE_DIR}/libevent.a)
WIN_dk_libDebug		(${LIBEVENT}/${OS}/${DEBUG_DIR}/event.lib)
WIN_dk_libRelease	(${LIBEVENT}/${OS}/${RELEASE_DIR}/event.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} 
	-DEVENT_LIBRARY_STATIC=ON 
	-DEVENT_LIBRARY_SHARED=OFF 
	-DEVENT__DISABLE_TESTS=ON 
	${MBEDTLS_CMAKE} 
	${OPENSSL_CMAKE} 
	${LIBEVENT})


### COMPILE ###
dk_build(${LIBEVENT})