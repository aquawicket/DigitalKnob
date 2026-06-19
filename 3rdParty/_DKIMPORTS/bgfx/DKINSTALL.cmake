#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


###### bgfx ######
# https://github.com/bkaradzic/bgfx.git
# https://github.com/bkaradzic/bgfx/archive/f8b20616def6ee7e82a3c14361c8a432b5bd15da.zip
# https://github.com/bkaradzic/bgfx/archive/refs/heads/master.zip

dk_import()

### LINK ###
dk_include			("${bgfx}/include")
if(Unix)
	dk_libDebug		("${bgfx_Debug_Dir}/libbgfx.a")
	dk_libRelease	("${bgfx_Release_Dir}/libbgfx.a")
elseif()
	dk_libDebug		("${bgfx_Debug_Dir}/bgfx.lib")
	dk_libRelease	("${bgfx_Release_Dir}/bgfx.lib")
endif()

### GENERATE ###
dk_configure("${bgfx}")


### COMPILE ###
dk_build("${bgfx}")
