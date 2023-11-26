# https://github.com/thestk/rtmidi


### DEPEND ###
WIN_dk_depend(winmm.lib)


### IMPORT ###
dk_import(https://github.com/thestk/rtmidi.git)


### LINK ###
APPLE_dk_define		(__MACOSX_CORE__)
if(LINUX OR RASPBERRY OR ANDROID)
	dk_define		(__LINUX_ALSA__)
endif()
dk_include			(${RTMIDI})
UNIX_dk_libDebug	(${RTMIDI}/${OS}/${DEBUG_DIR}/librtmidi.a)
UNIX_dk_libRelease	(${RTMIDI}/${OS}/${RELEASE_DIR}/librtmidi.a)
WIN_dk_libDebug		(${RTMIDI}/${OS}/${DEBUG_DIR}/RtMidi.lib)
WIN_dk_libRelease	(${RTMIDI}/${OS}/${RELEASE_DIR}/RtMidi.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${RTMIDI})


### COMPILE ###
dk_build(${RTMIDI} rtmidi)
