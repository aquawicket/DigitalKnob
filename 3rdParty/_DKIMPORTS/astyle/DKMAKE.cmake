# http://astyle.sourceforge.net/
# https://sourceforge.net/projects/astyle/files/latest/download
# https://managedway.dl.sourceforge.net/project/astyle/astyle/astyle%203.1/AStyle_3.1_windows.zip


### IMPORT ###
dk_import(https://sourceforge.net/projects/astyle/files/astyle/astyle%203.1/AStyle_3.1_windows.zip)


### LINK ###
dk_include(${ASTYLE})
# TODO


### GENERATE / COMPILE ###
WIN_DEBUG_dk_setPath	(${ASTYLE}/${OS}/${DEBUG_DIR})
WIN_DEBUG_dk_msys		(${DKCONFIGURE_BUILD})
WIN_DEBUG_dk_msys		(make)
WIN_RELEASE_dk_setPath	(${ASTYLE}/${OS}/${RELEASE_DIR})
WIN_RELEASE_dk_msys		(${DKCONFIGURE_BUILD})
WIN_RELEASE_dk_msys		(make)

UNIX_DEBUG_dk_setPath		(${ASTYLE}/${OS}/${DEBUG_DIR})
UNIX_DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
UNIX_DEBUG_dk_queueCommand	(make)
UNIX_RELEASE_dk_setPath		(${ASTYLE}/${OS}/${RELEASE_DIR})
UNIX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
UNIX_RELEASE_dk_queueCommand(make)
