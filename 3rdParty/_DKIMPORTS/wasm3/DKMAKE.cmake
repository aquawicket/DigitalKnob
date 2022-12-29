# https://github.com/wasm3/wasm3.git


### IMPORT ###
dk_import(https://github.com/wasm3/wasm3.git BRANCH main)


### LINK ###
dk_include			(${WASM3})
dk_include			(${WASM3}/${OS})
WIN_dk_libDebug		(${WASM3}/${OS}/${DEBUG_DIR}/wasm3.lib)
WIN_dk_libRelease	(${WASM3}/${OS}/${RELEASE_DIR}/wasm3.lib)
UNIX_dk_libDebug	(${WASM3}/${OS}/${DEBUG_DIR}/libwasm3.a)
UNIX_dk_libRelease	(${WASM3}/${OS}/${RELEASE_DIR}/libwasm3.a)


### GENERATE ###
dk_queueCommand	(${DKCMAKE_BUILD} ${WASM3})


### COMPILE ###
dk_build(${WASM3_FOLDER})
