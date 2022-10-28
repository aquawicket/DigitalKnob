# https://git.ffmpeg.org/ffmpeg.git


### IMPORT ###
dk_import(https://git.ffmpeg.org/ffmpeg.git)


### LINK ###
dk_include			(${FFMPEG}/src)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/ffmpeg.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/ffmpeg.lib)
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libffmpeg.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libffmpeg.a)


### GENERATE / COMPILE ###
WIN_DEBUG_dk_setPath	(${FFMPEG}/${OS}/${DEBUG_DIR})
WIN_DEBUG_dk_msys		(${DKCONFIGURE_BUILD})
WIN_DEBUG_dk_msys		(make)
WIN_RELEASE_dk_setPath	(${FFMPEG}/${OS}/${RELEASE_DIR})
WIN_RELEASE_dk_msys		(${DKCONFIGURE_BUILD})
WIN_RELEASE_dk_msys		(make)

UNIX_DEBUG_dk_setPath		(${FFMPEG}/${OS}/${DEBUG_DIR})
UNIX_DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
UNIX_DEBUG_dk_queueCommand	(make)
UNIX_RELEASE_dk_setPath		(${FFMPEG}/${OS}/${RELEASE_DIR})
UNIX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
UNIX_RELEASE_dk_queueCommand(make)
