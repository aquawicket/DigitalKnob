# https://github.com/pocoproject/poco.git


### IMPORT ###
dk_import(https://github.com/pocoproject/poco.git)


### LINK ###
dk_include			(${POCO}/include)
dk_include			(${POCO}/${OS})
WIN_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/poco.lib)
WIN_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/poco.lib)
UNIX_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/libpoco.a)
UNIX_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/libpoco.a)


### GENERATE ###
dk_setPath(${POCO}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${POCO})


### COMPILE ###
dk_build(${POCO_FOLDER})
