#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libwebsockets ############
# https://libwebsockets.org
# https://github.com/warmcat/libwebsockets
# https://github.com/warmcat/libwebsockets/archive/v2.2.0.zip
dk_load(dk_builder)

### DEPEND ###
#dk_depend(openssl)

### IMPORT ###
dk_import(https://github.com/warmcat/libwebsockets/archive/6b950e86.zip)

### LINK ###
dk_include			(${LIBWEBSOCKETS}/lib)
dk_include			(${LIBWEBSOCKETS}/${target_triple})
if(MSVC)
	dk_libDebug		(${LIBWEBSOCKETS}/${target_triple}/lib/${DEBUG_DIR}/websockets_static.lib)
	dk_libRelease	(${LIBWEBSOCKETS}/${target_triple}/lib/${RELEASE_DIR}/websockets_static.lib)
else()
	dk_libDebug		(${LIBWEBSOCKETS_DEBUG_DIR}/lib/libwebsockets_static.a)
	dk_libRelease	(${LIBWEBSOCKETS_RELEASE_DIR}/lib/libwebsockets_static.a)
endif()

### GENERATE ###
dk_configure(${LIBWEBSOCKETS} 
		-DLWS_WITH_MINIMAL_EXAMPLES=OFF
		-DLWS_WITH_SSL=OFF)

### COMPILE ###
dk_build(${LIBWEBSOCKETS} websockets)
