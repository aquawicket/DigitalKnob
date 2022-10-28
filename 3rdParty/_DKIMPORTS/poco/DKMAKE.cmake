# https://github.com/pocoproject/poco.git


### IMPORT ###
dk_import(https://github.com/pocoproject/poco.git)


### LINK ###
dk_include				(${POCO}/include)
dk_include				(${POCO}/${OS})
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoFoundationmdd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoFoundationm.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoFoundationd.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoFoundation.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoFoundationd.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoFoundation.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoFoundationd.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoFoundation.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoFoundationmdd.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoFoundationm.a)


### GENERATE ###
dk_setPath(${POCO}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} -DPOCO_MT=ON ${POCO})


### COMPILE ###
dk_build(${POCO_FOLDER})
