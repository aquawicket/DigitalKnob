# https://sourceforge.net/projects/waave
# https://sourceforge.net/projects/waave/files/waave/waave-3.01.tar.gz

dk_depend(ffmpeg-dev)
dk_depend(ffmpeg-shared)
dk_depend(ffmpeg-static)
dk_depend(sdl)


dk_import(https://sourceforge.net/projects/waave/files/waave/waave-3.01.tar.gz)
#dk_import(git://git.code.sf.net/p/waave/code)


### LINK ###
dk_include(${WAAVE}/src)
WIN_dk_libDebug(${WAAVE}/${OS}/${DEBUG_DIR}/waave.lib)
WIN_dk_libRelease(${WAAVE}/${OS}/${RELEASE_DIR}/waave.lib)
APPLE_dk_libDebug(${WAAVE}/${OS}/${DEBUG_DIR}/libwaave.a)
APPLE_dk_libRelease(${WAAVE}/${OS}/${RELEASE_DIR}/libwaave.a)
LINUX_dk_libDebug(${WAAVE}/${OS}/${DEBUG_DIR}/libwaave.a)
LINUX_dk_libRelease(${WAAVE}/${OS}/${RELEASE_DIR}/libwaave.a)
ANDROID_dk_libDebug(${WAAVE}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libwaave.a)
ANDROID_dk_libRelease(${WAAVE}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libwaave.a)


### GENERATE ###
dk_setPath(${WAAVE}/${BUILD_DIR})
WIN_dk_queueCommand(${DKCMAKE_BUILD} ${FFMPEG_WIN} ${SDL2_WIN} ${WAAVE})
#WIN64_dk_queueCommand(${DKCMAKE_BUILD} ${FFMPEG_WIN} ${SDL2_WIN} ${WAAVE})
#MAC64_dk_queueCommand(${DKCMAKE_BUILD} ${WAAVE})
MAC_dk_queueCommand(${DKCMAKE_BUILD} ${WAAVE})
#IOS64_dk_queueCommand(${DKCMAKE_BUILD} ${WAAVE})
IOS_dk_queueCommand(${DKCMAKE_BUILD} ${WAAVE})
#IOSSIM64_dk_queueCommand(${DKCMAKE_BUILD} ${WAAVE})
IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} ${WAAVE})
LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} ${WAAVE})
LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} ${WAAVE})


### COMPILE ###
WIN_dk_visualStudio(${WAAVE_NAME} waave)
MAC_dk_xcode(${WAAVE_NAME} waave)
IOS_dk_xcode(${WAAVE_NAME} waave)
IOSSIM_dk_xcode(${WAAVE_NAME} waave)
LINUX_DEBUG_dk_queueCommand(make waave)
LINUX_RELEASE_dk_queueCommand(make waave)
ANDROID_dk_ndk(${WAAVE_NAME})
