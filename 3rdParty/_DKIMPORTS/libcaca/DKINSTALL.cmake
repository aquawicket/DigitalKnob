#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


########### libcaca ############
# https://github.com/cacalabs/libcaca.git
# http://caca.zoy.org/wiki/libcaca

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/cacalabs/libcaca/archive/refs/heads/main.zip)

### LINK ###
dk_include			(${LIBCACA}/include)
dk_include			(${LIBCACA}/${target_triple})
UNIX_dk_libDebug	(${LIBCACA_DEBUG_DIR}/libcacad.a)
UNIX_dk_libRelease	(${LIBCACA_RELEASE_DIR}/libcaca.a)
WIN_dk_libDebug		(${LIBCACA_DEBUG_DIR}/libcacad.lib)
WIN_dk_libRelease	(${LIBCACA_RELEASE_DIR}/libcaca.lib)

### GENERATE ####
dk_configure(${LIBCACA_DIR})

### COMPILE ###
dk_build(${LIBCACA} libcaca)
