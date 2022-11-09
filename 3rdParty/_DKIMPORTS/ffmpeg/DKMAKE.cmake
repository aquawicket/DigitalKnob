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
DEBUG_dk_setPath		(${FFMPEG}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueshell		(${DKCONFIGURE_BUILD})
DEBUG_dk_queueshell		(make)
RELEASE_dk_setPath		(${FFMPEG}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueshell	(${DKCONFIGURE_BUILD})
RELEASE_dk_queueshell	(make)
