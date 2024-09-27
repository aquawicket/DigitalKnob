#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/thestk/rtmidi


### DEPEND ###
WIN_dk_depend(winmm)


### IMPORT ###
#dk_import(https://github.com/thestk/rtmidi.git)
dk_import(https://github.com/thestk/rtmidi/archive/refs/heads/master.zip)


### LINK ###
APPLE_dk_define		(__MACOSX_CORE__)
if(LINUX OR RASPBERRY OR ANDROID)
	dk_define		(__LINUX_ALSA__)
endif()
dk_include			(${RTMIDI})
UNIX_dk_libDebug	(${RTMIDI}/${triple}/${DEBUG_DIR}/librtmidi.a)
UNIX_dk_libRelease	(${RTMIDI}/${triple}/${RELEASE_DIR}/librtmidi.a)
WIN_dk_libDebug		(${RTMIDI}/${triple}/${DEBUG_DIR}/RtMidi.lib)
WIN_dk_libRelease	(${RTMIDI}/${triple}/${RELEASE_DIR}/RtMidi.lib)


### GENERATE ###
dk_configure(${RTMIDI})


### COMPILE ###
dk_build(${RTMIDI} rtmidi)
