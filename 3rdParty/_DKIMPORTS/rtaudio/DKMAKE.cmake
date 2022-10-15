# https://github.com/thestk/rtaudio


### DEPEND ###
WIN_dk_depend(winmm.lib)


### IMPORT ###
dk_import(https://github.com/thestk/rtaudio.git)


### LINK ###
APPLE_dk_define(__MACOSX_CORE__)
if(LINUX OR RASPBERRY OR ANDROID)
	dk_define(__LINUX_ALSA__)
endif()
dk_include				(${RTAUDIO})
WIN_dk_libDebug			(${RTAUDIO}/${OS}/${DEBUG_DIR}/RtAudio.lib)
WIN_dk_libRelease		(${RTAUDIO}/${OS}/${RELEASE_DIR}/RtAudio.lib)
MAC_dk_libDebug			(${RTAUDIO}/${OS}/${DEBUG_DIR}/libRtAudio.a)
MAC_dk_libRelease		(${RTAUDIO}/${OS}/${RELEASE_DIR}/libRtAudio.a)
IOS_dk_libDebug			(${RTAUDIO}/${OS}/${DEBUG_DIR}/libRtAudio.a)
IOS_dk_libRelease		(${RTAUDIO}/${OS}/${RELEASE_DIR}/libRtAudio.a)
IOSSIM_dk_libDebug		(${RTAUDIO}/${OS}/${DEBUG_DIR}/libRtAudio.a)
IOSSIM_dk_libRelease	(${RTAUDIO}/${OS}/${RELEASE_DIR}/libRtAudio.a)
LINUX_dk_libDebug		(${RTAUDIO}/${OS}/${DEBUG_DIR}/librtmidi.a)
LINUX_dk_libRelease		(${RTAUDIO}/${OS}/${RELEASE_DIR}/librtmidi.a)
RASPBERRY_dk_libDebug	(${RTAUDIO}/${OS}/${DEBUG_DIR}/libRtAudio.a)
RASPBERRY_dk_libRelease	(${RTAUDIO}/${OS}/${RELEASE_DIR}/libRtAudio.a)
ANDROID_dk_libDebug		(${RTAUDIO}/${OS}/${DEBUG_DIR}/libRtAudio.a)
ANDROID_dk_libRelease	(${RTAUDIO}/${OS}/${RELEASE_DIR}/libRtAudio.a)


### GENERATE ###
dk_setPath		(${RTAUDIO}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} ${RTAUDIO})


### COMPILE ###
dk_visualStudio	(${RTAUDIO_NAME} rtaudio) # windows, android
dk_xcode		(${RTAUDIO_NAME} rtaudio) # mac, ios, iossim
dk_make			(${RTAUDIO_NAME} rtaudio) # linux, raspberry
