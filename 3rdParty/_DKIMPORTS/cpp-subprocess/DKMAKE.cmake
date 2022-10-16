# https://github.com/tsaarni/cpp-subprocess


### IMPORT ###
dk_import(https://github.com/tsaarni/cpp-subprocess.git)


### LINK ###
dk_include(${CPP-SUBPROCESS})
# TODO


### GENERATE / COMPILE ###
WIN_DEBUG_dk_setPath	(${CPP-SUBPROCESS}/${OS}/${DEBUG_DIR})
WIN_DEBUG_dk_msys		(${DKCONFIGURE_BUILD})
WIN_DEBUG_dk_msys		(make)
WIN_RELEASE_dk_setPath	(${CPP-SUBPROCESS}/${OS}/${RELEASE_DIR})
WIN_RELEASE_dk_msys		(${DKCONFIGURE_BUILD})
WIN_RELEASE_dk_msys		(make)

UNIX_DEBUG_dk_setPath		(${CPP-SUBPROCESS}/${OS}/${DEBUG_DIR})
UNIX_DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
UNIX_DEBUG_dk_queueCommand	(make)
UNIX_RELEASE_dk_setPath		(${CPP-SUBPROCESS}/${OS}/${RELEASE_DIR})
UNIX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
UNIX_RELEASE_dk_queueCommand(make)