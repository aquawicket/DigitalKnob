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
WIN_dk_libDebug			(${RTAUDIO}/${OS}/${DEBUG_DIR}/rtaudiod.lib)
WIN_dk_libRelease		(${RTAUDIO}/${OS}/${RELEASE_DIR}/rtaudio.lib)
MAC_dk_libDebug			(${RTAUDIO}/${OS}/${DEBUG_DIR}/librtaudio.a)
MAC_dk_libRelease		(${RTAUDIO}/${OS}/${RELEASE_DIR}/librtaudio.a)
IOS_dk_libDebug			(${RTAUDIO}/${OS}/${DEBUG_DIR}/librtaudio.a)
IOS_dk_libRelease		(${RTAUDIO}/${OS}/${RELEASE_DIR}/librtaudio.a)
IOSSIM_dk_libDebug		(${RTAUDIO}/${OS}/${DEBUG_DIR}/librtaudio.a)
IOSSIM_dk_libRelease	(${RTAUDIO}/${OS}/${RELEASE_DIR}/librtaudio.a)
LINUX_dk_libDebug		(${RTAUDIO}/${OS}/${DEBUG_DIR}/librtaudio.a)
LINUX_dk_libRelease		(${RTAUDIO}/${OS}/${RELEASE_DIR}/librtaudio.a)
RASPBERRY_dk_libDebug	(${RTAUDIO}/${OS}/${DEBUG_DIR}/librtaudio.a)
RASPBERRY_dk_libRelease	(${RTAUDIO}/${OS}/${RELEASE_DIR}/librtaudio.a)
ANDROID_dk_libDebug		(${RTAUDIO}/${OS}/${DEBUG_DIR}/librtaudio.a)
ANDROID_dk_libRelease	(${RTAUDIO}/${OS}/${RELEASE_DIR}/librtaudio.a)


### GENERATE ###
dk_queueCommand	(${DKCMAKE_BUILD} ${RTAUDIO})


### COMPILE ###
dk_build(${RTAUDIO} rtaudio)
