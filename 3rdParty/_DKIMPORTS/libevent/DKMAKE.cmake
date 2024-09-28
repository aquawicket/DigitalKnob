#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/libevent/libevent.git


### DEPEND ###
dk_depend(mbedtls)
dk_depend(openssl)


### IMPORT ###
#dk_import(https://github.com/libevent/libevent.git)
dk_import(https://github.com/libevent/libevent/archive/refs/heads/master.zip)

### LINK ###
dk_include			(${LIBEVENT}/include)
UNIX_dk_libDebug	(${LIBEVENT}/${triple}/${DEBUG_DIR}/libevent.a)
UNIX_dk_libRelease	(${LIBEVENT}/${triple}/${RELEASE_DIR}/libevent.a)
WIN_dk_libDebug		(${LIBEVENT}/${triple}/${DEBUG_DIR}/event.lib)
WIN_dk_libRelease	(${LIBEVENT}/${triple}/${RELEASE_DIR}/event.lib)


### GENERATE ###
dk_configure(${LIBEVENT_DIR}
	-DEVENT_LIBRARY_STATIC=ON 
	-DEVENT_LIBRARY_SHARED=OFF 
	-DEVENT__DISABLE_TESTS=ON
	-DEVENT__DISABLE_REGRESS=ON
	-DEVENT__DISABLE_SAMPLES=ON
	${MBEDTLS_CMAKE} 
	${OPENSSL_CMAKE})


### COMPILE ###
dk_build(${LIBEVENT})