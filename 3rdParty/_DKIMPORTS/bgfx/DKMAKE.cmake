#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


# https://github.com/bkaradzic/bgfx.git

### DEPENDS ###
#dk_depend(libname)


### INSTALL ###
dk_import(https://github.com/bkaradzic/bgfx/archive/f8b20616def6ee7e82a3c14361c8a432b5bd15da.zip)
#dk_import(https://github.com/bkaradzic/bgfx/archive/refs/heads/master.zip)



### LINK ###
dk_include			(${BGFX_DIR}/include)
if(UNIX)
	dk_libDebug		(${BGFX_DEBUG_DIR}/libbgfx.a)
	dk_libRelease	(${BGFX_RELEASE_DIR}/libbgfx.a)
elseif()
	dk_libDebug		(${BGFX_DEBUG_DIR}/bgfx.lib)
	dk_libRelease	(${BGFX_RELEASE_DIR}/bgfx.lib)
endif()

### GENERATE ###
dk_configure(${BGFX_DIR})


### COMPILE ###
dk_build(${BGFX_DIR})
