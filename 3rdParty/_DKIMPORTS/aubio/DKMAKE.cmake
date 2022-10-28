# https://github.com/aubio/aubio.git


### IMPORT ###
dk_import(https://github.com/aubio/aubio.git)


### LINK ###
dk_include			(${AUBIO}/src)
WIN_dk_libDebug		(${AUBIO}/${OS}/${DEBUG_DIR}/aubio.lib)
WIN_dk_libRelease	(${AUBIO}/${OS}/${RELEASE_DIR}/aubio.lib)
UNIX_dk_libDebug	(${AUBIO}/${OS}/${DEBUG_DIR}/libaubio.a)
UNIX_dk_libRelease	(${AUBIO}/${OS}/${RELEASE_DIR}/libaubio.a)


### GENERATE / COMPILE ###
WIN_DEBUG_dk_setPath	(${AUBIO}/${OS}/${DEBUG_DIR})
WIN_DEBUG_dk_msys		(${DKCONFIGURE_BUILD})
WIN_DEBUG_dk_msys		(make)
WIN_RELEASE_dk_setPath	(${AUBIO}/${OS}/${RELEASE_DIR})
WIN_RELEASE_dk_msys		(${DKCONFIGURE_BUILD})
WIN_RELEASE_dk_msys		(make)

UNIX_DEBUG_dk_setPath		(${AUBIO}/${OS}/${DEBUG_DIR})
UNIX_DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
UNIX_DEBUG_dk_queueCommand	(make)
UNIX_RELEASE_dk_setPath		(${AUBIO}/${OS}/${RELEASE_DIR})
UNIX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
UNIX_RELEASE_dk_queueCommand(make)
