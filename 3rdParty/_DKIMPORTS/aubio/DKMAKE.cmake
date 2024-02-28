# https://github.com/aubio/aubio.git


### IMPORT ###
dk_import(https://github.com/aubio/aubio.git)


### LINK ###
dk_include				(${AUBIO}/src)
if(MSVC)
	WIN_dk_libDebug		(${AUBIO}/${OS}/${DEBUG_DIR}/aubio.lib)
	WIN_dk_libRelease	(${AUBIO}/${OS}/${RELEASE_DIR}/aubio.lib)
else()
	dk_libDebug			(${AUBIO}/${OS}/${DEBUG_DIR}/libaubio.a)
	dk_libRelease		(${AUBIO}/${OS}/${RELEASE_DIR}/libaubio.a)
endif()




### GENERATE ###
DEBUG_dk_setPath		(${AUBIO}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})

RELEASE_dk_setPath		(${AUBIO}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})


### COMPILE ###
dk_build				(${AUBIO})