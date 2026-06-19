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


############ rtmidi ############
# https://github.com/thestk/rtmidi
# https://github.com/thestk/rtmidi/archive/24b3a3bf.zip

dk_depend(winmm)

dk_import()

if(Apple)
	dk_define		(__MACOSX_CORE__)
endif()
if(Linux OR Raspberry OR Android)
	dk_define		(__LINUX_ALSA__)
endif()
dk_include			(${rtmidi})
if(MSVC)
	dk_libDebug		(${rtmidi_Debug_Dir}/RtMidi.lib)
	dk_libRelease	(${rtmidi_Release_Dir}/RtMidi.lib)
else()
	dk_libDebug		(${rtmidi_Debug_Dir}/librtmidi.a)
	dk_libRelease	(${rtmidi_Release_Dir}/librtmidi.a)
endif()

dk_configure(${rtmidi})

dk_build(${rtmidi} rtmidi)
