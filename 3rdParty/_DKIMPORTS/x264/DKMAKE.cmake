# https://code.videolan.org/videolan/x264


### IMPORT ###
dk_import(https://code.videolan.org/videolan/x264.git)


### LINK ###
dk_include(${X264})
# TODO


### GENERATE / COMPILE ###
WIN_DEBUG_dk_setPath	(${X264}/${OS}/${DEBUG_DIR})
WIN_DEBUG_dk_msys		(${DKCONFIGURE_BUILD})
WIN_DEBUG_dk_msys		(make)
WIN_RELEASE_dk_setPath	(${X264}/${OS}/${RELEASE_DIR})
WIN_RELEASE_dk_msys		(${DKCONFIGURE_BUILD})
WIN_RELEASE_dk_msys		(make)

UNIX_DEBUG_dk_setPath		(${X264}/${OS}/${DEBUG_DIR})
UNIX_DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
UNIX_DEBUG_dk_queueCommand	(make)
UNIX_RELEASE_dk_setPath		(${X264}/${OS}/${RELEASE_DIR})
UNIX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
UNIX_RELEASE_dk_queueCommand(make)
