#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


# https://github.com/thestk/rtaudio


dk_validate(Target_Tuple "dk_Target_Tuple()")

### DEPEND ###
if(Windows)
	dk_depend(winmm)
endif()

### IMPORT ###
#dk_import(https://github.com/thestk/rtaudio.git)
dk_import(https://github.com/thestk/rtaudio/archive/refs/heads/master.zip)


### LINK ###
if(Apple)
	dk_define			(__MACOSX_CORE__)
endif()
if(Linux OR Raspberry OR Android)
	dk_define			(__LINUX_ALSA__)
endif()
dk_include				(${RTAUDIO})
if(MSVC)
	dk_libDebug			(${RTAUDIO_Debug_Dir}/rtaudiod.lib)
	dk_libRelease		(${RTAUDIO_Release_Dir}/rtaudio.lib)
else()
	dk_libDebug			(${RTAUDIO_Debug_Dir}/librtaudiod.a)
	dk_libRelease		(${RTAUDIO_Release_Dir}/librtaudio.a)
endif()


### GENERATE ###
dk_configure(${RTAUDIO})


### COMPILE ###
dk_build(${RTAUDIO} rtaudio)
