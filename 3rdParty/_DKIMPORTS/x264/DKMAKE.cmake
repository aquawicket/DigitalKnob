# https://code.videolan.org/videolan/x264.git


### IMPORT ###
dk_import(https://code.videolan.org/videolan/x264.git)


### LINK ###
dk_include			(${X264}/include)
dk_include			(${X264}/${OS})
WIN_dk_libDebug		(${X264}/${OS}/${DEBUG_DIR}/x264.lib)
WIN_dk_libRelease	(${X264}/${OS}/${RELEASE_DIR}/x264.lib)
UNIX_dk_libDebug	(${X264}/${OS}/${DEBUG_DIR}/libx264.a)
UNIX_dk_libRelease	(${X264}/${OS}/${RELEASE_DIR}/libx264.a)


### GENERATE / COMPILE ###
DEBUG_dk_setPath		(${X264}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueShell		(${DKCONFIGURE_BUILD})
DEBUG_dk_queueShell		(make)
RELEASE_dk_setPath		(${X264}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueShell	(${DKCONFIGURE_BUILD})
RELEASE_dk_queueShell	(make)
