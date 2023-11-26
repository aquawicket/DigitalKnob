# https://github.com/creationix/dukluv.git
# https://github.com/creationix/dukluv/archive/f02103bcadd5a5b9280b7a07064649d0a465f70c.zip


### DEPEND ###
dk_depend(duktape)
dk_depend(libuv)


### IMPORT ###
#dk_import(https://github.com/creationix/dukluv/archive/f02103bcadd5a5b9280b7a07064649d0a465f70c.zip)
dk_import(https://github.com/creationix/dukluv.git)


### LINK ###
dk_include			(${DUKLUV}/include)
dk_include			(${DUKLUV}/${OS})
UNIX_dk_libDebug	(${DUKLUV}/${OS}/${DEBUG_DIR}/libdukluv.a)
UNIX_dk_libRelease	(${DUKLUV}/${OS}/${RELEASE_DIR}/libdukluv.a)
WIN_dk_libDebug		(${DUKLUV}/${OS}/${DEBUG_DIR}/dukluv.lib)
WIN_dk_libRelease	(${DUKLUV}/${OS}/${RELEASE_DIR}/dukluv.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${DUKTAPE_CMAKE} ${LIBUV_CMAKE} ${DUKLUV})


### COMPILE ###
dk_build(${DUKLUV})
