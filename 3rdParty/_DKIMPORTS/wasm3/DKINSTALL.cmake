#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ wasm3 ############
# https://github.com/wasm3/wasm3.git
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/wasm3/wasm3/archive/79d412ea.zip)

### LINK ###
dk_include				(${WASM3})
dk_include				(${WASM3}/${Target_Triple})
APPLE_dk_libDebug		(${WASM3}/${Target_Triple}/source/${DEBUG_DIR}/libm3.a)
APPLE_dk_libRelease		(${WASM3}/${Target_Triple}/source/${RELEASE_DIR}/libm3.a)
if(NOT APPLE)
	UNIX_dk_libDebug	(${WASM3_DEBUG_DIR}/source/libm3.a)
	UNIX_dk_libRelease	(${WASM3_RELEASE_DIR}/source/libm3.a)
endif()
WIN_dk_libDebug			(${WASM3}/${Target_Triple}/source/${DEBUG_DIR}/m3.lib)
WIN_dk_libRelease		(${WASM3}/${Target_Triple}/source/${RELEASE_DIR}/m3.lib)

### GENERATE ###
dk_configure(${WASM3})

### COMPILE ###
dk_build(${WASM3})
