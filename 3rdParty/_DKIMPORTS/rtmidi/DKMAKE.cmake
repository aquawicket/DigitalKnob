# https://github.com/thestk/rtmidi


#dk_import(https://github.com/thestk/rtmidi)
#dk_set(RTMIDI_SLN RtMidi.sln)
#dk_set(RTMIDI_TARGET rtmidi)

dk_import(http://www.music.mcgill.ca/~gary/rtmidi/release/rtmidi-2.1.0.tar.gz PATCH)

#dk_set(RTMIDI_VERSION 2.1.0)
#dk_set(RTMIDI_DL http://www.music.mcgill.ca/~gary/rtmidi/release/rtmidi-2.1.0.tar.gz)
#dk_set(RTMIDI_NAME rtmidi-${RTMIDI_VERSION})
#dk_set(RTMIDI ${3RDPARTY}/${RTMIDI_NAME})
#dk_install(${RTMIDI_DL} rtmidi ${RTMIDI} PATCH)

dk_set(RTMIDI_SLN Project.sln)
dk_set(RTMIDI_TARGET RtMidi)


### LINK ###
dk_include(${RTMIDI})
if(WIN)
	dk_depend(winmm.lib)
endif()
if(APPLE)
	dk_define(__MACOSX_CORE__)
endif()
if(LINUX OR RASPBERRY OR ANDROID)
	dk_define(__LINUX_ALSA__)
endif()
WIN_dk_libDebug(${RTMIDI}/${OS}/${DEBUG_DIR}/RtMidi.lib)
WIN_dk_libRelease(${RTMIDI}/${OS}/${RELEASE_DIR}/RtMidi.lib)
MAC_dk_libDebug(${RTMIDI}/${OS}/${DEBUG_DIR}/libRtMidi.a)
MAC_dk_libRelease(${RTMIDI}/${OS}/${RELEASE_DIR}/libRtMidi.a)
IOS_dk_libDebug(${RTMIDI}/${OS}/${DEBUG_DIR}/libRtMidi.a)
IOS_dk_libRelease(${RTMIDI}/${OS}/${RELEASE_DIR}/libRtMidi.a)
IOSSIM_dk_libDebug(${RTMIDI}/${OS}/${DEBUG_DIR}/libRtMidi.a)
IOSSIM_dk_libRelease(${RTMIDI}/${OS}/${RELEASE_DIR}/libRtMidi.a)
LINUX_dk_libDebug(${RTMIDI}/${OS}/${DEBUG_DIR}/libRtMidi.a)
LINUX_dk_libRelease(${RTMIDI}/${OS}/${RELEASE_DIR}/libRtMidi.a)
RASPBERRY_dk_libDebug(${RTMIDI}/${OS}/${DEBUG_DIR}/libRtMidi.a)
RASPBERRY_dk_libRelease(${RTMIDI}/${OS}/${RELEASE_DIR}/libRtMidi.a)
ANDROID_dk_libDebug(${RTMIDI}/${OS}/${DEBUG_DIR}/libRtMidi.a)
ANDROID_dk_libRelease(${RTMIDI}/${OS}/${RELEASE_DIR}/libRtMidi.a)

### COMPILE ###
WIN_dk_setPath(${RTMIDI}/${OS})
WIN32_dk_queueCommand(${DKCMAKE_BUILD} ${RTMIDI})
WIN64_dk_queueCommand(${DKCMAKE_BUILD} ${RTMIDI})
WIN_dk_visualStudio(${RTMIDI_NAME} ${RTMIDI_SLN} ${RTMIDI_TARGET})


MAC_dk_setPath(${RTMIDI}/${OS})
MAC64_dk_queueCommand(${DKCMAKE_BUILD} ${RTMIDI})
MAC_dk_xcode(${RTMIDI_NAME} ${RTMIDI_TARGET})

IOS_dk_setPath(${RTMIDI}/${OS})
IOS64_dk_queueCommand(${DKCMAKE_BUILD} ${RTMIDI})
IOS_dk_xcode(${RTMIDI_NAME} ${RTMIDI_TARGET})

IOSSIM_dk_setPath(${RTMIDI}/${OS})
IOSSIM64_dk_queueCommand(${DKCMAKE_BUILD} ${RTMIDI})
IOSSIM_dk_xcode(${RTMIDI_NAME} ${RTMIDI_TARGET})


LINUX_DEBUG_dk_setPath(${RTMIDI}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} ${RTMIDI})
LINUX_DEBUG_dk_queueCommand(make ${RTMIDI_TARGET})
LINUX_RELEASE_dk_setPath(${RTMIDI}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} ${RTMIDI})
LINUX_RELEASE_dk_queueCommand(make ${RTMIDI_TARGET})


RASPBERRY_DEBUG_dk_setPath(${RTMIDI}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} ${RTMIDI})
RASPBERRY_DEBUG_dk_queueCommand(make ${RTMIDI_TARGET})
RASPBERRY_RELEASE_dk_setPath(${RTMIDI}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} ${RTMIDI})
RASPBERRY_RELEASE_dk_queueCommand(make ${RTMIDI_TARGET})


ANDROID_dk_setPath(${RTMIDI}/${OS})
ANDROID32_dk_queueCommand(${DKCMAKE_BUILD} ${RTMIDI})
ANDROID64_dk_queueCommand(${DKCMAKE_BUILD} ${RTMIDI})
ANDROID_dk_visualStudio(${RTMIDI_NAME} Project.sln ${RTMIDI_TARGET})