#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")

############ uwebsockets ############
# https://github.com/uNetworking/uWebSockets
dk_load(dk_builder)

### DEPEND ###
dk_depend(libuv)
dk_depend(openssl)
dk_depend(zlib)

### IMPORT ###
dk_import(https://github.com/uNetworking/uWebSockets/archive/refs/tags/v0.14.8.zip PATCH)
#dk_import(https://github.com/uNetworking/uWebSockets/archive/refs/tags/v20.36.0.zip)

### LINK ###
dk_include				(${UWEBSOCKETS})
dk_include				(${UWEBSOCKETS}/${target_triple})
if(MSVC)
	WIN_dk_libDebug		(${UWEBSOCKETS_DEBUG_DIR}/uWS.lib)
	WIN_dk_libRelease	(${UWEBSOCKETS_RELEASE_DIR}/uWS.lib)
else()
	dk_libDebug			(${UWEBSOCKETS_DEBUG_DIR}/libuWS.a)
	dk_libRelease		(${UWEBSOCKETS_RELEASE_DIR}/libuWS.a)
endif()

### GENERATE ###
dk_configure(${UWEBSOCKETS}
	${LIBUV_CMAKE}
	${OPENSSL_CMAKE}
	${ZLIB_CMAKE})

### COMPILE ###
dk_build(${UWEBSOCKETS} uWS)

###### WITHOUT CMAKE #########
#DEBUG_dk_configure			(${UWEBSOCKETS})
#DEBUG_dk_build				(${UWEBSOCKETS})
##############################

