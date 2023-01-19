# https://github.com/wasm3/wasm3.git


### IMPORT ###
dk_import(https://github.com/wasm3/wasm3.git BRANCH main)


### LINK ###
dk_include				(${WASM3})
dk_include				(${WASM3}/${OS})
APPLE_dk_libDebug		(${WASM3}/${OS}/source/${DEBUG_DIR}/libm3.a)
APPLE_dk_libRelease		(${WASM3}/${OS}/source/${RELEASE_DIR}/libm3.a)
if(NOT APPLE)
	UNIX_dk_libDebug	(${WASM3}/${OS}/${DEBUG_DIR}/source/libm3.a)
	UNIX_dk_libRelease	(${WASM3}/${OS}/${RELEASE_DIR}/source/libm3.a)
endif()
WIN_dk_libDebug			(${WASM3}/${OS}/source/${DEBUG_DIR}/m3.lib)
WIN_dk_libRelease		(${WASM3}/${OS}/source/${RELEASE_DIR}/m3.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${WASM3})


### COMPILE ###
dk_build(${WASM3})
