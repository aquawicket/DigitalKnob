#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


###### bgfx ######
# https://github.com/bkaradzic/bgfx.git
# https://github.com/bkaradzic/bgfx/archive/f8b20616.zip
# https://github.com/bkaradzic/bgfx/archive/refs/heads/master.zip
#
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import		(${BGFX_IMPORT})

### LINK ###
dk_include			("${BGFX}/include")
if(Unix)
	dk_libDebug		("${BGFX.Debug_Dir}/libbgfx.a")
	dk_libRelease	("${BGFX.Release_Dir}/libbgfx.a")
elseif()
	dk_libDebug		("${BGFX.Debug_Dir}/bgfx.lib")
	dk_libRelease	("${BGFX.Release_Dir}/bgfx.lib")
endif()

### GENERATE ###
dk_configure("${BGFX}")


### COMPILE ###
dk_build("${BGFX}")
