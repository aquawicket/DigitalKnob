#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libexpat ############
# https://github.com/libexpat/libexpat.git
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/libexpat/libexpat/archive/b70c8f5.zip)

### LINK ###
dk_include			(${LIBEXPAT}/include							    LIBEXPAT_INCLUDE_DIR)
dk_include			(${LIBEXPAT}/${triple})
UNIX_dk_libDebug	(${LIBEXPAT_DEBUG_DIR}/libexpat.a		LIBEXPAT_LIBRARY_DEBUG)
UNIX_dk_libRelease	(${LIBEXPAT_RELEASE_DIR}/libexpat.a	LIBEXPAT_LIBRARY_RELEASE)
WIN_dk_libDebug		(${LIBEXPAT_DEBUG_DIR}/libexpat.lib	LIBEXPAT_LIBRARY_DEBUG)
WIN_dk_libRelease	(${LIBEXPAT_RELEASE_DIR}/libexpat.lib	LIBEXPAT_LIBRARY_RELEASE)

### GENERATE ###
dk_configure(${LIBEXPAT_DIR}/expat)

### COMPILE ###
dk_build(${LIBEXPAT})
