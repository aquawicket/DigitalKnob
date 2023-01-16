# https://github.com/thestk/rtmidi


### DEPEND ###
WIN_dk_depend(winmm.lib)


### IMPORT ###
dk_import(https://github.com/thestk/rtmidi.git)


### LINK ###
APPLE_dk_define(__MACOSX_CORE__)
if(LINUX OR RASPBERRY OR ANDROID)
	dk_define(__LINUX_ALSA__)
endif()
dk_include				(${RTMIDI})
WIN_dk_libDebug			(${RTMIDI}/${OS}/${DEBUG_DIR}/RtMidi.lib)
WIN_dk_libRelease		(${RTMIDI}/${OS}/${RELEASE_DIR}/RtMidi.lib)
MAC_dk_libDebug			(${RTMIDI}/${OS}/${DEBUG_DIR}/libRtMidi.a)
MAC_dk_libRelease		(${RTMIDI}/${OS}/${RELEASE_DIR}/libRtMidi.a)
IOS_dk_libDebug			(${RTMIDI}/${OS}/${DEBUG_DIR}/libRtMidi.a)
IOS_dk_libRelease		(${RTMIDI}/${OS}/${RELEASE_DIR}/libRtMidi.a)
IOSSIM_dk_libDebug		(${RTMIDI}/${OS}/${DEBUG_DIR}/libRtMidi.a)
IOSSIM_dk_libRelease	(${RTMIDI}/${OS}/${RELEASE_DIR}/libRtMidi.a)
LINUX_dk_libDebug		(${RTMIDI}/${OS}/${DEBUG_DIR}/librtmidi.a)
LINUX_dk_libRelease		(${RTMIDI}/${OS}/${RELEASE_DIR}/librtmidi.a)
RASPBERRY_dk_libDebug	(${RTMIDI}/${OS}/${DEBUG_DIR}/libRtMidi.a)
RASPBERRY_dk_libRelease	(${RTMIDI}/${OS}/${RELEASE_DIR}/libRtMidi.a)
ANDROID_dk_libDebug		(${RTMIDI}/${OS}/${DEBUG_DIR}/libRtMidi.a)
ANDROID_dk_libRelease	(${RTMIDI}/${OS}/${RELEASE_DIR}/libRtMidi.a)


### GENERATE ###
dk_queueCommand	(${DKCMAKE_BUILD} ${RTMIDI})


### COMPILE ###
dk_build(${RTMIDI} rtmidi)
