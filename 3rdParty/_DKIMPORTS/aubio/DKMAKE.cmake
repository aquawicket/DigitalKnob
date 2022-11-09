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
DEBUG_dk_setPath		(${AUBIO}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueshell		(${DKCONFIGURE_BUILD})
DEBUG_dk_queueshell		(make)
RELEASE_dk_setPath		(${AUBIO}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueshell	(${DKCONFIGURE_BUILD})
RELEASE_dk_queueshell	(make)
