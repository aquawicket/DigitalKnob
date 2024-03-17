# https://github.com/thestk/rtaudio


### DEPEND ###
WIN_dk_depend(winmm.lib)


### IMPORT ###
dk_import(https://github.com/thestk/rtaudio.git)


### LINK ###
APPLE_dk_define			(__MACOSX_CORE__)
if(LINUX OR RASPBERRY OR ANDROID)
	dk_define			(__LINUX_ALSA__)
endif()
dk_include				(${RTAUDIO})
UNIX_dk_libDebug		(${RTAUDIO}/${OS}/${DEBUG_DIR}/librtaudio.a)
UNIX_dk_libRelease		(${RTAUDIO}/${OS}/${RELEASE_DIR}/librtaudio.a)
WIN_dk_libDebug			(${RTAUDIO}/${OS}/${DEBUG_DIR}/rtaudiod.lib)
WIN_dk_libRelease		(${RTAUDIO}/${OS}/${RELEASE_DIR}/rtaudio.lib)


### GENERATE ###
dk_configure(${RTAUDIO})


### COMPILE ###
dk_build(${RTAUDIO} rtaudio)
