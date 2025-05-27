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


############ wasm3 ############
# https://github.com/wasm3/wasm3.git
dk_validate(CONFIG_PATH  "dk_CONFIG_PATH()")

### IMPORT ###
dk_import(https://github.com/wasm3/wasm3/archive/79d412ea.zip)

### LINK ###
dk_include				(${WASM3})
dk_include				(${WASM3}/${Target_Tuple})
APPLE_dk_libDebug		(${WASM3}/${Target_Tuple}/source/${Debug_Dir}/libm3.a)
APPLE_dk_libRelease		(${WASM3}/${Target_Tuple}/source/${Release_Dir}/libm3.a)
if(NOT Apple)
	UNIX_dk_libDebug	(${WASM3_DEBUG_DIR}/source/libm3.a)
	UNIX_dk_libRelease	(${WASM3_RELEASE_DIR}/source/libm3.a)
endif()
Windows_dk_libDebug			(${WASM3}/${Target_Tuple}/source/${Debug_Dir}/m3.lib)
Windows_dk_libRelease		(${WASM3}/${Target_Tuple}/source/${Release_Dir}/m3.lib)

### GENERATE ###
dk_configure(${WASM3})

### COMPILE ###
dk_build(${WASM3})
