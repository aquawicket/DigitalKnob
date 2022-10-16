# https://bitbucket.org/multicoreware/x265_git


### IMPORT ###
dk_import(https://bitbucket.org/multicoreware/x265_git.git)


### LINK ###
dk_include(${X265})
# TODO


### GENERATE / COMPILE ###
WIN_DEBUG_dk_setPath	(${X265}/${OS}/${DEBUG_DIR})
WIN_DEBUG_dk_msys		(${DKCONFIGURE_BUILD})
WIN_DEBUG_dk_msys		(make)
WIN_RELEASE_dk_setPath	(${X265}/${OS}/${RELEASE_DIR})
WIN_RELEASE_dk_msys		(${DKCONFIGURE_BUILD})
WIN_RELEASE_dk_msys		(make)

UNIX_DEBUG_dk_setPath		(${X265}/${OS}/${DEBUG_DIR})
UNIX_DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
UNIX_DEBUG_dk_queueCommand	(make)
UNIX_RELEASE_dk_setPath		(${X265}/${OS}/${RELEASE_DIR})
UNIX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
UNIX_RELEASE_dk_queueCommand(make)
