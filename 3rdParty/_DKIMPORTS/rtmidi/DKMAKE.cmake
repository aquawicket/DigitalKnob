include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/thestk/rtmidi


### DEPEND ###
WIN_TARGET_dk_depend(winmm)


### IMPORT ###
#dk_import(https://github.com/thestk/rtmidi.git)
dk_import(https://github.com/thestk/rtmidi/archive/refs/heads/master.zip)


### LINK ###
APPLE_dk_define		(__MACOSX_CORE__)
if(LINUX OR RASPBERRY OR ANDROID)
	dk_define		(__LINUX_ALSA__)
endif()
dk_include			(${RTMIDI})
UNIX_dk_libDebug	(${RTMIDI}/${OS}/${DEBUG_DIR}/librtmidi.a)
UNIX_dk_libRelease	(${RTMIDI}/${OS}/${RELEASE_DIR}/librtmidi.a)
WIN_TARGET_dk_libDebug		(${RTMIDI}/${OS}/${DEBUG_DIR}/RtMidi.lib)
WIN_TARGET_dk_libRelease	(${RTMIDI}/${OS}/${RELEASE_DIR}/RtMidi.lib)


### GENERATE ###
dk_configure(${RTMIDI})


### COMPILE ###
dk_build(${RTMIDI} rtmidi)
