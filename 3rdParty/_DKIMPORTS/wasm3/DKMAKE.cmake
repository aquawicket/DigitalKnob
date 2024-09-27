#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/wasm3/wasm3.git


### IMPORT ###
#dk_import(https://github.com/wasm3/wasm3.git BRANCH main)
dk_import(https://github.com/wasm3/wasm3/archive/refs/heads/main.zip)


### LINK ###
dk_include				(${WASM3})
dk_include				(${WASM3}/${triple})
APPLE_dk_libDebug		(${WASM3}/${triple}/source/${DEBUG_DIR}/libm3.a)
APPLE_dk_libRelease		(${WASM3}/${triple}/source/${RELEASE_DIR}/libm3.a)
if(NOT APPLE)
	UNIX_dk_libDebug	(${WASM3}/${triple}/${DEBUG_DIR}/source/libm3.a)
	UNIX_dk_libRelease	(${WASM3}/${triple}/${RELEASE_DIR}/source/libm3.a)
endif()
WIN_dk_libDebug			(${WASM3}/${triple}/source/${DEBUG_DIR}/m3.lib)
WIN_dk_libRelease		(${WASM3}/${triple}/source/${RELEASE_DIR}/m3.lib)


### GENERATE ###
dk_configure(${WASM3})


### COMPILE ###
dk_build(${WASM3})
