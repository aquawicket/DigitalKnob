#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/creationix/dukluv.git
# https://github.com/creationix/dukluv/archive/f02103bcadd5a5b9280b7a07064649d0a465f70c.zip


### DEPEND ###
dk_depend(duktape)
dk_depend(libuv)


### IMPORT ###
#dk_import(https://github.com/creationix/dukluv.git)
#dk_import(https://github.com/creationix/dukluv/archive/f02103bcadd5a5b9280b7a07064649d0a465f70c.zip)
dk_import(https://github.com/creationix/dukluv/archive/refs/heads/master.zip)



### LINK ###
dk_include	(${DUKLUV}/include)
dk_include	(${DUKLUV}/${triple})
if(MSVC)
	WIN_dk_libDebug		(${DUKLUV}/${triple}/${DEBUG_DIR}/dukluv.lib)
	WIN_dk_libRelease	(${DUKLUV}/${triple}/${RELEASE_DIR}/dukluv.lib)
else()
	dk_libDebug			(${DUKLUV}/${triple}/${DEBUG_DIR}/libdukluv.a)
	dk_libRelease		(${DUKLUV}/${triple}/${RELEASE_DIR}/libdukluv.a)
endif()



### GENERATE ###
dk_configure(${DUKLUV_DIR} ${DUKTAPE_CMAKE} ${LIBUV_CMAKE})


### COMPILE ###
dk_build(${DUKLUV})
