#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libjodycode ############
# https://github.com/jbruchon/libjodycode.git

dk_load(dk_builder)

### INSTALL ###
dk_import(https://github.com/jbruchon/libjodycode.git)

### LINK ###
dk_include			(${LIBJODYCODE}/include)
UNIX_dk_libDebug	(${LIBJODYCODE_DEBUG_DIR}/libjodycode.a)
UNIX_dk_libRelease	(${LIBJODYCODE_RELEASE_DIR}/libjodycode.a)
WIN_dk_libDebug		(${LIBJODYCODE_DEBUG_DIR}/libjodycode.lib)
WIN_dk_libRelease	(${LIBJODYCODE_RELEASE_DIR}/libjodycode.lib)

### GENERATE ###
dk_configure(${LIBJODYCODE_DIR})

### COMPILE ###
dk_build(${LIBJODYCODE_DIR} libjodycode)
