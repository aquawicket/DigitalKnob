#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/libexpat/libexpat.git


### IMPORT ###
#dk_import(https://github.com/libexpat/libexpat/archive/f1a444ef64680ebd4ff89091a2c388cd046ece2d.zip)
#dk_import(https://github.com/libexpat/libexpat.git)
dk_import(https://github.com/libexpat/libexpat/archive/refs/heads/master.zip)


### LINK ###
dk_include			(${LIBEXPAT}/include							    LIBEXPAT_INCLUDE_DIR)
dk_include			(${LIBEXPAT}/${triple})
UNIX_dk_libDebug	(${LIBEXPAT}/${triple}/${DEBUG_DIR}/libexpat.a		LIBEXPAT_LIBRARY_DEBUG)
UNIX_dk_libRelease	(${LIBEXPAT}/${triple}/${RELEASE_DIR}/libexpat.a	LIBEXPAT_LIBRARY_RELEASE)
WIN_dk_libDebug		(${LIBEXPAT}/${triple}/${DEBUG_DIR}/libexpat.lib	LIBEXPAT_LIBRARY_DEBUG)
WIN_dk_libRelease	(${LIBEXPAT}/${triple}/${RELEASE_DIR}/libexpat.lib	LIBEXPAT_LIBRARY_RELEASE)


### GENERATE ###
dk_configure(${LIBEXPAT_DIR}/expat)


### COMPILE ###
dk_build(${LIBEXPAT})
