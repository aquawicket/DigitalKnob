#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################

############ rtaudio ############
# https://github.com/thestk/rtaudio
# https://github.com/thestk/rtaudio/archive/refs/heads/master.zip

dk_depend(winmm)

dk_import()


### LINK ###
if(Apple)
	dk_define			(__MACOSX_CORE__)
endif()
if(Linux OR Raspberry OR Android)
	dk_define			(__LINUX_ALSA__)
endif()
dk_include				(${rtaudio})
if(MSVC)
	dk_libDebug			(${rtaudio_Debug_Dir}/rtaudiod.lib)
	dk_libRelease		(${rtaudio_Release_Dir}/rtaudio.lib)
else()
	dk_libDebug			(${rtaudio_Debug_Dir}/librtaudiod.a)
	dk_libRelease		(${rtaudio_Release_Dir}/librtaudio.a)
endif()


### GENERATE ###
dk_configure(${rtaudio})


### COMPILE ###
dk_build(${rtaudio} rtaudio)
