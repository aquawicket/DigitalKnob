#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


# https://github.com/thestk/rtaudio


dk_validate(triple "dk_TARGET_TRIPLE()")

### DEPEND ###
if(WIN)
	dk_depend(winmm)
endif()

### IMPORT ###
#dk_import(https://github.com/thestk/rtaudio.git)
dk_import(https://github.com/thestk/rtaudio/archive/refs/heads/master.zip)


### LINK ###
if(APPLE)
	dk_define			(__MACOSX_CORE__)
endif()
if(LINUX OR RASPBERRY OR ANDROID)
	dk_define			(__LINUX_ALSA__)
endif()
dk_include				(${RTAUDIO})
if(UNIX)
	dk_libDebug			(${RTAUDIO}/${triple}/${DEBUG_DIR}/librtaudio.a)
	dk_libRelease		(${RTAUDIO}/${triple}/${RELEASE_DIR}/librtaudio.a)
endif()
if(WIN)
	dk_libDebug			(${RTAUDIO}/${triple}/${DEBUG_DIR}/rtaudiod.lib)
	dk_libRelease		(${RTAUDIO}/${triple}/${RELEASE_DIR}/rtaudio.lib)
endif()

### GENERATE ###
dk_configure(${RTAUDIO})


### COMPILE ###
dk_build(${RTAUDIO} rtaudio)
