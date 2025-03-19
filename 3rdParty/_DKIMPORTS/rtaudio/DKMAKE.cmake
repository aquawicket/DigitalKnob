#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


# https://github.com/thestk/rtaudio


dk_validate(target_triple "dk_target_triple()")

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
if(MSVC)
	dk_libDebug			(${RTAUDIO_DEBUG_DIR}/rtaudiod.lib)
	dk_libRelease		(${RTAUDIO_RELEASE_DIR}/rtaudio.lib)
else()
	dk_libDebug			(${RTAUDIO_DEBUG_DIR}/librtaudiod.a)
	dk_libRelease		(${RTAUDIO_RELEASE_DIR}/librtaudio.a)
endif()


### GENERATE ###
dk_configure(${RTAUDIO})


### COMPILE ###
dk_build(${RTAUDIO} rtaudio)
