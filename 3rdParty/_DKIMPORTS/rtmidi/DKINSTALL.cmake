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


############ rtmidi ############
# https://github.com/thestk/rtmidi

dk_validate(Target_Tuple "dk_Target_Tuple()")

### DEPEND ###
if(Windows)
	dk_depend(winmm)
endif()

### IMPORT ###
dk_import(https://github.com/thestk/rtmidi/archive/24b3a3bf.zip)

### LINK ###
if(Apple)
	dk_define		(__MACOSX_CORE__)
endif()
if(Linux OR Raspberry OR Android)
	dk_define		(__LINUX_ALSA__)
endif()
dk_include			(${RTMIDI})
if(MSVC)
	dk_libDebug		(${RTMIDI.Debug_Dir}/RtMidi.lib)
	dk_libRelease	(${RTMIDI.Release_Dir}/RtMidi.lib)
else()
	dk_libDebug		(${RTMIDI.Debug_Dir}/librtmidi.a)
	dk_libRelease	(${RTMIDI.Release_Dir}/librtmidi.a)
endif()


### GENERATE ###
dk_configure(${RTMIDI})

### COMPILE ###
dk_build(${RTMIDI} rtmidi)
