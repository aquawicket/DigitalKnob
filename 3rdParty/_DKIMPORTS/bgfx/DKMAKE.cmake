#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/bkaradzic/bgfx.git

### DEPENDS ###
#dk_depend(libname)


### INSTALL ###
#dk_import(https://github.com/bkaradzic/bgfx.git)
dk_import(https://github.com/bkaradzic/bgfx/archive/refs/heads/master.zip)



### LINK ###
dk_include			(${BGFX_DIR}/include)
UNIX_dk_libDebug	(${BGFX_DEBUG_DIR}/libbgfx.a)
UNIX_dk_libRelease	(${BGFX_RELEASE_DIR}/libbgfx.a)
WIN_dk_libDebug		(${BGFX_DEBUG_DIR}/bgfx.lib)
WIN_dk_libRelease	(${BGFX_RELEASE_DIR}/bgfx.lib)


### GENERATE ###
dk_configure(${BGFX_DIR})


### COMPILE ###
dk_build(${BGFX_DIR})
