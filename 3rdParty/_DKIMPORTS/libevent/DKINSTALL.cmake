#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libevent ############
# https://github.com/libevent/libevent.git

dk_load(dk_builder)

### DEPEND ###
dk_depend(mbedtls)
dk_depend(openssl)

### IMPORT ###
dk_import(https://github.com/libevent/libevent/archive/2a1ec766.zip)

### LINK ###
dk_include			(${LIBEVENT}/include)
UNIX_dk_libDebug	(${LIBEVENT_DEBUG_DIR}/libevent.a)
UNIX_dk_libRelease	(${LIBEVENT_RELEASE_DIR}/libevent.a)
Windows_dk_libDebug		(${LIBEVENT_DEBUG_DIR}/event.lib)
Windows_dk_libRelease	(${LIBEVENT_RELEASE_DIR}/event.lib)


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