# Obsolete - replaced by RmlUi
#
# https://github.com/libRocket/libRocket/archive/master.zip

dk_depend(freetype)


dk_import(https://github.com/libRocket/libRocket)
#dk_set(ROCKET_VERSION master)
#dk_set(ROCKET_NAME libRocket-${ROCKET_VERSION})
#dk_set(ROCKET_DL https://github.com/libRocket/libRocket/archive/${ROCKET_VERSION}.zip)
#dk_set(ROCKET ${3RDPARTY}/${ROCKET_NAME})
#dk_install(${ROCLET_DL} libRocket ${ROCKET})


#dk_rename(${DKDOWNLOAD}/${ROCKET_VERSION}.zip ${DKDOWNLOAD}/${ROCKET_NAME}.zip)

##SET(STRING "${GIT_EXE} clone https://github.com/aquawicket/libRocket.git ${3RDPARTY}/${ROCKET_NAME}")
##FILE(MAKE_DIRECTORY ${3RDPARTY}/${ROCKET_NAME})
##dk_command(${STRING})




### LINK ###
dk_define(ROCKET_STATIC_LIB)
dk_include(${ROCKET}/Include)

WIN_DEBUG_DKLIB(${ROCKET}/${OS}/Debug/RocketDebugger.lib)
WIN_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/RocketDebugger.lib)
MAC_DEBUG_DKLIB(${ROCKET}/${OS}/${DEBUG_DIR}/libRocketDebugger.a)
MAC_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketDebugger.a)
IOSSIM_DEBUG_DKLIB(${ROCKET}/${OS}/${DEBUG_DIR}/libRocketDebugger_d.a)
IOSSIM_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketDebugger.a)
LINUX_DEBUG_DKLIB(${ROCKET}/${OS}/Debug/libRocketDebugger.a)
LINUX_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketDebugger.a)
ANDROID_DEBUG_DKLIB(${ROCKET}/${OS}/Debug/obj/local/armeabi-v7a/libRocketDebugger.a)
ANDROID_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libRocketDebugger.a)

WIN_DEBUG_DKLIB(${ROCKET}/${OS}/Debug/RocketControls.lib)
WIN_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/RocketControls.lib)
MAC_DEBUG_DKLIB(${ROCKET}/${OS}/${DEBUG_DIR}/libRocketControls.a)
MAC_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketControls.a)
IOSSIM_DEBUG_DKLIB(${ROCKET}/${OS}/${DEBUG_DIR}/libRocketControls_d.a)
IOSSIM_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketControls.a)
LINUX_DEBUG_DKLIB(${ROCKET}/${OS}/Debug/libRocketControls.a)
LINUX_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketControls.a)
ANDROID_DEBUG_DKLIB(${ROCKET}/${OS}/Debug/obj/local/armeabi-v7a/libRocketControls.a)
ANDROID_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libRocketControls.a)

WIN_DEBUG_DKLIB(${ROCKET}/${OS}/Debug/RocketCore.lib)
WIN_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/RocketCore.lib)
MAC_DEBUG_DKLIB(${ROCKET}/${OS}/${DEBUG_DIR}/libRocketCore.a)
MAC_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketCore.a)
IOSSIM_DEBUG_DKLIB(${ROCKET}/${OS}/${DEBUG_DIR}/libRocketCore_d.a)
IOSSIM_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketCore.a)
LINUX_DEBUG_DKLIB(${ROCKET}/${OS}/Debug/libRocketCore.a)
LINUX_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketCore.a)
ANDROID_DEBUG_DKLIB(${ROCKET}/${OS}/Debug/obj/local/armeabi-v7a/libRocketCore.a)
ANDROID_RELEASE_DKLIB(${ROCKET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libRocketCore.a)



### COMPILE ###
dk_setPath(${ROCKET}/${BUILD_DIR})

WIN_dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/I${ROCKET}/Include" ${FREETYPE_CMAKE} ${ROCKET})
WIN_VS(${ROCKET_NAME} libRocket.sln)

MAC_dk_queueCommand(${DKCMAKE_BUILD} ${FREETYPE_CMAKE} ${ROCKET})
MAC_XCODE(${ROCKET_NAME})

IOS_dk_queueCommand(${DKCMAKE_BUILD} ${FREETYPE_CMAKE} ${ROCKET})
IOS_XCODE(${ROCKET_NAME})

IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} ${FREETYPE_CMAKE} ${ROCKET})
IOSSIM_XCODE(${ROCKET_NAME})

LINUX_dk_queueCommand(${DKCMAKE_BUILD} ${FREETYPE_CMAKE} ${ROCKET})
LINUX_dk_queueCommand(make)

ANDROID_NDK(${ROCKET_NAME})