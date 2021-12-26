# Obsolete - replaced by RmlUi
#
# https://github.com/libRocket/libRocket/archive/master.zip

DKDEPEND(freetype)


### VERSION ###
DKSET(ROCKET_VERSION master)
DKSET(ROCKET_NAME libRocket-${ROCKET_VERSION})
DKSET(ROCKET_DL https://github.com/libRocket/libRocket/archive/${ROCKET_VERSION}.zip)
DKSET(ROCKET ${3RDPARTY}/${ROCKET_NAME})


### INSTALL ###
DKINSTALL(${ROCLET_DL} libRocket ${ROCKET})
#DKRENAME(${DKDOWNLOAD}/${ROCKET_VERSION}.zip ${DKDOWNLOAD}/${ROCKET_NAME}.zip)

##SET(STRING "${GIT_EXE} clone https://github.com/aquawicket/libRocket.git ${3RDPARTY}/${ROCKET_NAME}")
##FILE(MAKE_DIRECTORY ${3RDPARTY}/${ROCKET_NAME})
##DKCOMMAND(${STRING})




### LINK ###
DKDEFINE(ROCKET_STATIC_LIB)
DKINCLUDE(${ROCKET}/Include)

WIN_DEBUG_LIB(${ROCKET}/${OS}/Debug/RocketDebugger.lib)
WIN_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/RocketDebugger.lib)
MAC_DEBUG_LIB(${ROCKET}/${OS}/${DEBUG_DIR}/libRocketDebugger.a)
MAC_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketDebugger.a)
IOSSIM_DEBUG_LIB(${ROCKET}/${OS}/${DEBUG_DIR}/libRocketDebugger_d.a)
IOSSIM_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketDebugger.a)
LINUX_DEBUG_LIB(${ROCKET}/${OS}/Debug/libRocketDebugger.a)
LINUX_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketDebugger.a)
ANDROID_DEBUG_LIB(${ROCKET}/${OS}/Debug/obj/local/armeabi-v7a/libRocketDebugger.a)
ANDROID_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libRocketDebugger.a)

WIN_DEBUG_LIB(${ROCKET}/${OS}/Debug/RocketControls.lib)
WIN_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/RocketControls.lib)
MAC_DEBUG_LIB(${ROCKET}/${OS}/${DEBUG_DIR}/libRocketControls.a)
MAC_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketControls.a)
IOSSIM_DEBUG_LIB(${ROCKET}/${OS}/${DEBUG_DIR}/libRocketControls_d.a)
IOSSIM_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketControls.a)
LINUX_DEBUG_LIB(${ROCKET}/${OS}/Debug/libRocketControls.a)
LINUX_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketControls.a)
ANDROID_DEBUG_LIB(${ROCKET}/${OS}/Debug/obj/local/armeabi-v7a/libRocketControls.a)
ANDROID_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libRocketControls.a)

WIN_DEBUG_LIB(${ROCKET}/${OS}/Debug/RocketCore.lib)
WIN_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/RocketCore.lib)
MAC_DEBUG_LIB(${ROCKET}/${OS}/${DEBUG_DIR}/libRocketCore.a)
MAC_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketCore.a)
IOSSIM_DEBUG_LIB(${ROCKET}/${OS}/${DEBUG_DIR}/libRocketCore_d.a)
IOSSIM_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketCore.a)
LINUX_DEBUG_LIB(${ROCKET}/${OS}/Debug/libRocketCore.a)
LINUX_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/libRocketCore.a)
ANDROID_DEBUG_LIB(${ROCKET}/${OS}/Debug/obj/local/armeabi-v7a/libRocketCore.a)
ANDROID_RELEASE_LIB(${ROCKET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libRocketCore.a)



### COMPILE ###
DKSETPATH(${ROCKET}/${BUILD_DIR})

WIN_DKQCOMMAND(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/I${ROCKET}/Include" ${FREETYPE_CMAKE} ${ROCKET})
WIN_VS(${ROCKET_NAME} libRocket.sln)

MAC_DKQCOMMAND(${DKCMAKE_BUILD} ${FREETYPE_CMAKE} ${ROCKET})
MAC_XCODE(${ROCKET_NAME})

IOS_DKQCOMMAND(${DKCMAKE_BUILD} ${FREETYPE_CMAKE} ${ROCKET})
IOS_XCODE(${ROCKET_NAME})

IOSSIM_DKQCOMMAND(${DKCMAKE_BUILD} ${FREETYPE_CMAKE} ${ROCKET})
IOSSIM_XCODE(${ROCKET_NAME})

LINUX_DKQCOMMAND(${DKCMAKE_BUILD} ${FREETYPE_CMAKE} ${ROCKET})
LINUX_DKQCOMMAND(make)

ANDROID_NDK(${ROCKET_NAME})