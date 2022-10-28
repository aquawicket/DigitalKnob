# https://github.com/pocoproject/poco.git


### IMPORT ###
dk_import(https://github.com/pocoproject/poco.git)


### LINK ###
dk_include			(${POCO}/include)
dk_include			(${POCO}/${OS})
WIN_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoFoundationmdd.lib)
WIN_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoFoundationm.lib)
UNIX_dk_libDebug	(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoFoundation.a)
UNIX_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoFoundation.a)


### GENERATE ###
dk_setPath(${POCO}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} -DPOCO_MT=ON ${POCO})


### COMPILE ###
dk_build(${POCO_FOLDER})
