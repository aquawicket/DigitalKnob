# https://github.com/creationix/dukluv.git
# https://github.com/creationix/dukluv/archive/f02103bcadd5a5b9280b7a07064649d0a465f70c.zip


### DEPEND ###
dk_depend(duktape)
dk_depend(libuv)


### IMPORT ###
#dk_import(https://github.com/creationix/dukluv/archive/f02103bcadd5a5b9280b7a07064649d0a465f70c.zip)
dk_import(https://github.com/creationix/dukluv.git)


### LINK ###
dk_include	(${DUKLUV}/include)
dk_include	(${DUKLUV}/${OS})
if(MSVC)
	WIN_dk_libDebug		(${DUKLUV}/${OS}/${DEBUG_DIR}/dukluv.lib)
	WIN_dk_libRelease	(${DUKLUV}/${OS}/${RELEASE_DIR}/dukluv.lib)
else()
	dk_libDebug			(${DUKLUV}/${OS}/${DEBUG_DIR}/libdukluv.a)
	dk_libRelease		(${DUKLUV}/${OS}/${RELEASE_DIR}/libdukluv.a)
endif()



### GENERATE ###
dk_configure(${DUKLUV} ${DUKTAPE_CMAKE} ${LIBUV_CMAKE})


### COMPILE ###
dk_build(${DUKLUV})
