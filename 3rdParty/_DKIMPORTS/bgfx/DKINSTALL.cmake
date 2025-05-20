#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### bgfx ######
# https://github.com/bkaradzic/bgfx.git
# https://github.com/bkaradzic/bgfx/archive/f8b20616.zip
# https://github.com/bkaradzic/bgfx/archive/refs/heads/master.zip
#
dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParams("$ENV{DKIMPORTS_DIR}/babel/dkconfig.txt")
dk_import		(${BGFX_IMPORT})

### LINK ###
dk_include			("${BGFX_DIR}/include")
if(Unix)
	dk_libDebug		("${BGFX_DEBUG_DIR}/libbgfx.a")
	dk_libRelease	("${BGFX_RELEASE_DIR}/libbgfx.a")
elseif()
	dk_libDebug		("${BGFX_DEBUG_DIR}/bgfx.lib")
	dk_libRelease	("${BGFX_RELEASE_DIR}/bgfx.lib")
endif()

### GENERATE ###
dk_configure("${BGFX_DIR}")


### COMPILE ###
dk_build("${BGFX_DIR}")
