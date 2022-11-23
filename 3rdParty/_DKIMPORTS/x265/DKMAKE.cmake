# https://bitbucket.org/multicoreware/x265_git.git


### IMPORT ###
dk_import(https://bitbucket.org/multicoreware/x265_git.git)


### LINK ###
dk_include			(${X265}/include)
dk_include			(${X265}/${OS})
WIN_dk_libDebug		(${X265}/${OS}/${DEBUG_DIR}/x265.lib)
WIN_dk_libRelease	(${X265}/${OS}/${RELEASE_DIR}/x265.lib)
UNIX_dk_libDebug	(${X265}/${OS}/${DEBUG_DIR}/libx265.a)
UNIX_dk_libRelease	(${X265}/${OS}/${RELEASE_DIR}/libx265.a)


### GENERATE ###
#dk_setPath(${X265}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${X265})


### COMPILE ###
dk_build(${X265_FOLDER})
