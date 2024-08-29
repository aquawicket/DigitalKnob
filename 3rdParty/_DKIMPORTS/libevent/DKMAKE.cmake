include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/libevent/libevent.git


### DEPEND ###
dk_depend(mbedtls)
dk_depend(openssl)


### IMPORT ###
#dk_import(https://github.com/libevent/libevent.git)
dk_import(https://github.com/libevent/libevent/archive/refs/heads/master.zip)

### LINK ###
dk_include			(${LIBEVENT}/include)
UNIX_dk_libDebug	(${LIBEVENT}/${OS}/${DEBUG_DIR}/libevent.a)
UNIX_dk_libRelease	(${LIBEVENT}/${OS}/${RELEASE_DIR}/libevent.a)
WIN_TARGET_dk_libDebug		(${LIBEVENT}/${OS}/${DEBUG_DIR}/event.lib)
WIN_TARGET_dk_libRelease	(${LIBEVENT}/${OS}/${RELEASE_DIR}/event.lib)


### GENERATE ###
dk_configure(${LIBEVENT} 
	-DEVENT_LIBRARY_STATIC=ON 
	-DEVENT_LIBRARY_SHARED=OFF 
	-DEVENT__DISABLE_TESTS=ON
	-DEVENT__DISABLE_REGRESS=ON
	-DEVENT__DISABLE_SAMPLES=ON
	${MBEDTLS_CMAKE} 
	${OPENSSL_CMAKE})


### COMPILE ###
dk_build(${LIBEVENT})