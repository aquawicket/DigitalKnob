#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)
# https://github.com/mirror/libX11.git
# https://www.x.org/
# https://www.x.org/releases/individual/lib/
# https://www.x.org/releases/individual/lib/libX11-1.6.10.tar.gz


### IMPORT ###
#dk_import(https://github.com/mirror/libX11.git)
dk_import(https://github.com/mirror/libX11/archive/refs/tags/libX11-1.8.1.zip)



### LINK ###
dk_include			(${LIBX11}/include)
UNIX_dk_libDebug	(${LIBX11_DEBUG_DIR}/liblibx11d.a)
UNIX_dk_libRelease	(${LIBX11_RELEASE_DIR}/liblibx11.a)
WIN_dk_libDebug		(${LIBX11_DEBUG_DIR}/libx11d.lib)
WIN_dk_libRelease	(${LIBX11_RELEASE_DIR}/libx11.lib)


### GENERATE / COMPILE ###
DEBUG_dk_cd		(${LIBX11_DEBUG_DIR})
DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})

RELEASE_dk_cd		(${LIBX11_RELEASE_DIR})
RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})

dk_build				(${LIBX11})
