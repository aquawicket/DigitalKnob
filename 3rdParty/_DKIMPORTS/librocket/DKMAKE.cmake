# Obsolete - replaced by RmlUi
# https://github.com/libRocket/libRocket/archive/master.zip


### DEPEND ###
dk_depend(freetype)


### IMPORT ###
dk_import(https://github.com/libRocket/libRocket.git)


### LINK ###
dk_define				(ROCKET_STATIC_LIB)
dk_include				(${LIBROCKET}/Include)

WIN_dk_libDebug			(${LIBROCKET}/${OS}/Debug/RocketDebugger.lib)
WIN_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/RocketDebugger.lib)
MAC_dk_libDebug			(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketDebugger.a)
MAC_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketDebugger.a)
IOSSIM_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketDebugger_d.a)
IOSSIM_dk_libRelease	(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketDebugger.a)
LINUX_dk_libDebug		(${LIBROCKET}/${OS}/Debug/libRocketDebugger.a)
LINUX_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketDebugger.a)
ANDROID_dk_libDebug		(${LIBROCKET}/${OS}/Debug/obj/local/armeabi-v7a/libRocketDebugger.a)
ANDROID_dk_libRelease	(${LIBROCKET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libRocketDebugger.a)

WIN_dk_libDebug			(${LIBROCKET}/${OS}/Debug/RocketControls.lib)
WIN_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/RocketControls.lib)
MAC_dk_libDebug			(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketControls.a)
MAC_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketControls.a)
IOSSIM_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketControls_d.a)
IOSSIM_dk_libRelease	(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketControls.a)
LINUX_dk_libDebug		(${LIBROCKET}/${OS}/Debug/libRocketControls.a)
LINUX_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketControls.a)
ANDROID_dk_libDebug		(${LIBROCKET}/${OS}/Debug/obj/local/armeabi-v7a/libRocketControls.a)
ANDROID_dk_libRelease	(${LIBROCKET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libRocketControls.a)

WIN_dk_libDebug			(${LIBROCKET}/${OS}/Debug/RocketCore.lib)
WIN_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/RocketCore.lib)
MAC_dk_libDebug			(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketCore.a)
MAC_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketCore.a)
IOSSIM_dk_libDebug		(${LIBROCKET}/${OS}/${DEBUG_DIR}/libRocketCore_d.a)
IOSSIM_dk_libRelease	(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketCore.a)
LINUX_dk_libDebug		(${LIBROCKET}/${OS}/Debug/libRocketCore.a)
LINUX_dk_libRelease		(${LIBROCKET}/${OS}/${RELEASE_DIR}/libRocketCore.a)
ANDROID_dk_libDebug		(${LIBROCKET}/${OS}/Debug/obj/local/armeabi-v7a/libRocketCore.a)
ANDROID_dk_libRelease	(${LIBROCKET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libRocketCore.a)



### GENERATE ###
dk_setPath				(${LIBROCKET}/${BUILD_DIR})
WIN_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/I${LIBROCKET}/Include" ${FREETYPE_CMAKE} ${LIBROCKET})
MAC_dk_queueCommand		(${DKCMAKE_BUILD} ${FREETYPE_CMAKE} ${LIBROCKET})
IOS_dk_queueCommand		(${DKCMAKE_BUILD} ${FREETYPE_CMAKE} ${LIBROCKET})
IOSSIM_dk_queueCommand	(${DKCMAKE_BUILD} ${FREETYPE_CMAKE} ${LIBROCKET})
LINUX_dk_queueCommand	(${DKCMAKE_BUILD} ${FREETYPE_CMAKE} ${LIBROCKET})


### COMPILE ###
WIN_dk_visualStudio		(${ROCKET_NAME})
MAC_dk_xcode			(${ROCKET_NAME})
IOS_dk_xcode			(${ROCKET_NAME})
IOSSIM_dk_xcode			(${ROCKET_NAME})
LINUX_dk_queueCommand	(make)
ANDROID_dk_ndk			(${ROCKET_NAME})
