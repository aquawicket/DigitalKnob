# https://sourceforge.net/projects/waave/files/waave/waave-3.01.tar.gz

### DEPENDS ###
dk_depend(ffmpeg-dev)
dk_depend(ffmpeg-shared)
dk_depend(ffmpeg-static)
dk_depend(sdl)

dk_import(https://sourceforge.net/projects/waave/files/waave/waave-3.01.tar.gz)


### LINK ###
dk_include(${WAAVE}/src)
WIN_DEBUG_DKLIB(${WAAVE}/${OS}/${DEBUG_DIR}/waave.lib)
WIN_RELEASE_DKLIB(${WAAVE}/${OS}/${RELEASE_DIR}/waave.lib)
APPLE_DEBUG_DKLIB(${WAAVE}/${OS}/${DEBUG_DIR}/libwaave.a)
APPLE_RELEASE_DKLIB(${WAAVE}/${OS}/${RELEASE_DIR}/libwaave.a)
LINUX_DEBUG_DKLIB(${WAAVE}/${OS}/${DEBUG_DIR}/libwaave.a)
LINUX_RELEASE_DKLIB(${WAAVE}/${OS}/${RELEASE_DIR}/libwaave.a)
ANDROID_DEBUG_DKLIB(${WAAVE}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libwaave.a)
ANDROID_RELEASE_DKLIB(${WAAVE}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libwaave.a)


### COMPILE ###
dk_setPath(${WAAVE}/${BUILD_DIR})

WIN32_dk_queueCommand(${DKCMAKE_BUILD} ${FFMPEG_WIN} ${SDL2_WIN} ${WAAVE})
WIN64_dk_queueCommand(${DKCMAKE_BUILD} ${FFMPEG_WIN} ${SDL2_WIN} ${WAAVE})
WIN_dk_VisualStudio(${WAAVE_NAME} waave.sln waave)



MAC64_dk_queueCommand(${DKCMAKE_BUILD} ${WAAVE})
MAC_XCODE(${WAAVE_NAME} waave)



IOS64_dk_queueCommand(${DKCMAKE_BUILD} ${WAAVE})
IOS_XCODE(${WAAVE_NAME} waave)



IOSSIM64_dk_queueCommand(${DKCMAKE_BUILD} ${WAAVE})
IOSSIM_XCODE(${WAAVE_NAME} waave)



LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} ${WAAVE})
LINUX_DEBUG_dk_queueCommand(make waave)


LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} ${WAAVE})
LINUX_RELEASE_dk_queueCommand(make waave)


ANDROID_NDK(${WAAVE_NAME})
