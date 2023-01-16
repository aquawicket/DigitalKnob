# Obsolete - replaced by RmlUi
# https://github.com/libRocket/libRocket.git
# https://github.com/libRocket/libRocket/archive/master.zip


### DEPEND ###
dk_depend(freetype)


### IMPORT ###
dk_import(https://github.com/libRocket/libRocket.git)


### LINK ###
dk_define				(ROCKET_STATIC_LIB)
dk_include				(${LIBROCKET}/Include)

# RocketDebugger
WIN_dk_libDebug			(${LIBROCKET}/${OS}/${DEBUG_DIR}/RocketDebugger.lib)
WIN_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/RocketDebugger.lib)
APPLE_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketDebugger.a)
APPLE_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketDebugger.a)
LINUX_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketDebugger.a)
LINUX_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketDebugger.a)
RASPBERRY_dk_libDebug	(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketDebugger.a)
RASPBERRY_dk_libRelease	(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketDebugger.a)
ANDROID_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libRocketDebugger.a)
ANDROID_dk_libRelease	(${LIBROCKET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libRocketDebugger.a)

# RocketControls
WIN_dk_libDebug			(${LIBROCKET}/${OS}/${DEBUG_DIR}/RocketControls.lib)
WIN_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/RocketControls.lib)
APPLE_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketControls.a)
APPLE_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketControls.a)
LINUX_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketControls.a)
LINUX_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketControls.a)
RASPBERRY_dk_libDebug	(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketControls.a)
RASPBERRY_dk_libRelease	(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketControls.a)
ANDROID_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libRocketControls.a)
ANDROID_dk_libRelease	(${LIBROCKET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libRocketControls.a)

# RocketCore
WIN_dk_libDebug			(${LIBROCKET}/${OS}/${DEBUG_DIR}/RocketCore.lib)
WIN_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/RocketCore.lib)
APPLE_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketCore.a)
APPLE_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketCore.a)
LINUX_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketCore.a)
LINUX_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketCore.a)
RASPBERRY_dk_libDebug	(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketCore.a)
RASPBERRY_dk_libRelease	(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketCore.a)
ANDROID_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libRocketCore.a)
ANDROID_dk_libRelease	(${LIBROCKET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libRocketCore.a)


### GENERATE ###
WIN_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/I${LIBROCKET}/Include" ${FREETYPE_CMAKE} ${LIBROCKET})
UNIX_dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=-I${LIBROCKET}/Include" ${FREETYPE_CMAKE} ${LIBROCKET})


### COMPILE ###
dk_build(${LIBROCKET})
