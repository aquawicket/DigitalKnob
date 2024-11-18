#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ rtmidi ############
# https://github.com/thestk/rtmidi

dk_validate(triple "dk_target_triple()")

### DEPEND ###
if(WIN)
	dk_depend(winmm)
endif()

### IMPORT ###
dk_import(https://github.com/thestk/rtmidi/archive/24b3a3bf.zip)

### LINK ###
if(APPLE)
	dk_define		(__MACOSX_CORE__)
endif()
if(LINUX OR RASPBERRY OR ANDROID)
	dk_define		(__LINUX_ALSA__)
endif()
dk_include			(${RTMIDI})
if(MSVC)
	dk_libDebug		(${RTMIDI_DEBUG_DIR}/RtMidi.lib)
	dk_libRelease	(${RTMIDI_RELEASE_DIR}/RtMidi.lib)
else()
	dk_libDebug		(${RTMIDI_DEBUG_DIR}/librtmidi.a)
	dk_libRelease	(${RTMIDI_RELEASE_DIR}/librtmidi.a)
endif()


### GENERATE ###
dk_configure(${RTMIDI})

### COMPILE ###
dk_build(${RTMIDI} rtmidi)
