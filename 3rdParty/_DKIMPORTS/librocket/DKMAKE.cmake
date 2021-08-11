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
WIN_PATH(${ROCKET}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc /I${ROCKET}/Include" ${FREETYPE_WIN} ${ROCKET}/Build)
WIN64_COMMAND(${DKCMAKE_WIN64} "-DCMAKE_CXX_FLAGS=/DWIN64 /D_WINDOWS /W3 /nologo /GR /EHsc /I${ROCKET}/Include" ${FREETYPE_WIN} ${ROCKET}/Build)
WIN_VS(${ROCKET_NAME} libRocket.sln)


MAC_PATH(${ROCKET}/${OS})
MAC64_COMMAND(${DKCMAKE_MAC64} ${FREETYPE_APPLE} ${ROCKET}/Build)
MAC_XCODE(${ROCKET_NAME})

IOS_PATH(${ROCKET}/${OS})
IOS64_COMMAND(${DKCMAKE_IOS64} ${FREETYPE_APPLE} ${ROCKET}/Build)
IOS_XCODE(${ROCKET_NAME})

IOSSIM_PATH(${ROCKET}/${OS})
IOSSIM64_COMMAND(${DKCMAKE_IOSSIM64} ${FREETYPE_APPLE} ${ROCKET})
IOSSIM_XCODE(${ROCKET_NAME})


LINUX_DEBUG_PATH(${ROCKET}/${OS}/Debug)
LINUX_DEBUG_COMMAND(${DKCMAKE_LINUX_DEBUG} ${FREETYPE_LINUX} ${ROCKET}/Build)
LINUX_DEBUG_COMMAND(make)

LINUX_RELEASE_PATH(${ROCKET}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${DKCMAKE_LINUX_RELEASE} ${FREETYPE_LINUX} ${ROCKET}/Build)
LINUX_RELEASE_COMMAND(make)

ANDROID_NDK(${ROCKET_NAME})