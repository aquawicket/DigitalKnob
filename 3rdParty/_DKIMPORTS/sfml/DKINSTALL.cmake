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


###### sfml ######
# https://github.com/SFML/SFML
# https://www.sfml-dev.org
# https://github.com/SFML/SFML/archive/refs/heads/master.zip
# https://www.sfml-dev.org/files/SFML-2.5.1-sources.zip

dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
if(Android)
	dk_depend(freetype)
endif()	
if(IOS OR Iossim)
	dk_depend(audio_toolbox)
	dk_depend(av_foundation)
	dk_depend(core_audio)
	dk_depend(core_graphics)
	dk_depend(core_motion)
	dk_depend(foundation)
	dk_depend(game_controller)
	dk_depend(opengles)
	dk_depend(quartz_core)
	dk_depend(uikit)
endif()
if(Mac)
	dk_depend(appkit)
	dk_depend(audio_toolbox)
	dk_depend(audiounit)
	dk_depend(carbon)
	dk_depend(cocoa)
	dk_depend(core_audio)
	dk_depend(core_foundation)
	dk_depend(core_video)
	dk_depend(force_feedback)
	dk_depend(iokit)
	dk_depend(opengl)
endif()
if(Linux OR Raspberry)
	dk_depend(build-essential)
	dk_depend(libgtk2.0-dev)
	dk_depend(libsndfile1-dev)
	dk_depend(libudev-dev)
	dk_depend(libx11-dev)
	dk_depend(libxcursor-dev)
	dk_depend(libxrandr-dev)
#	dk_depend(mesa)
	dk_depend(openal)
	dk_depend(opengl)
endif()
if(Windows)
	dk_depend(opengl)
	dk_depend(winmm)
endif()
dk_depend(flac)
dk_depend(libjpeg-turbo)
dk_depend(ogg)
dk_depend(openal)
dk_depend(vorbis)


### IMPORT ###
#dk_import(https://github.com/SFML/SFML/archive/a733e4cd7e0056922e4f74f1932749b4d6a5744d.zip PATCH)
#dk_import(https://github.com/SFML/SFML.git PATCH)
dk_import(https://github.com/SFML/SFML/archive/refs/heads/master.zip PATCH)


### LINK ###
dk_define(SFML_STATIC)
dk_include(${SFML}/include)
dk_addTarget(sfml sfml-audio)
dk_addTarget(sfml sfml-graphics)
dk_addTarget(sfml sfml-main)
dk_addTarget(sfml sfml-network)
dk_addTarget(sfml sfml-system)
dk_addTarget(sfml sfml-window)

if(sfml_sfml-audio)
	Android_dk_libDebug		(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/libsfml-audio-s-d.a)
	Android_dk_libRelease	(${SFML}/${Target_Tuple}/lib/${Release_Dir}/libsfml-audio-s.a)
	Emscripten_dk_libDebug	(${SFML_Debug_Dir}/lib/libsfml-audio-s-d.a)
	Emscripten_dk_libRelease(${SFML_Release_Dir}/lib/libsfml-audio-s.a)
	Iossim_dk_libDebug		(${SFML}/${Target_Tuple}/lib/Debug/libsfml-audio-s-d.a)
	Iossim_dk_libRelease	(${SFML}/${Target_Tuple}/lib/Release/libsfml-audio-s.a)
	Ios_dk_libDebug			(${SFML}/${Target_Tuple}/lib/Debug/libsfml-audio-s-d.a)
	Ios_dk_libRelease		(${SFML}/${Target_Tuple}/lib/Release/libsfml-audio-s.a)
	Linux_dk_libDebug		(${SFML_Debug_Dir}/lib/libsfml-audio-s-d.a)
	Linux_dk_libRelease		(${SFML_Release_Dir}/lib/libsfml-audio-s.a)
	Mac_dk_libDebug			(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/libsfml-audio-s-d.a)
	Mac_dk_libRelease		(${SFML}/${Target_Tuple}/lib/${Release_Dir}/libsfml-audio-s.a)
	Raspberry_dk_libDebug	(${SFML_Debug_Dir}/lib/libsfml-audio-s-d.a)
	Raspberry_dk_libRelease	(${SFML_Release_Dir}/lib/libsfml-audio-s.a)
	Windows_dk_libDebug			(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/sfml-audio-s-d.lib)
	Windows_dk_libRelease		(${SFML}/${Target_Tuple}/lib/${Release_Dir}/sfml-audio-s.lib)
endif()

if(sfml_sfml-graphics)
	Android_dk_libDebug		(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/libsfml-graphics-s-d.a)
	Android_dk_libRelease	(${SFML}/${Target_Tuple}/lib/${Release_Dir}/libsfml-graphics-s.a)
	Emscripten_dk_libDebug	(${SFML_Debug_Dir}/lib/libsfml-graphics-s-d.a)
	Emscripten_dk_libRelease(${SFML_Release_Dir}/lib/libsfml-graphics-s.a)
	Iossim_dk_libDebug		(${SFML}/${Target_Tuple}/lib/Debug/libsfml-graphics-s-d.a)
	Iossim_dk_libRelease	(${SFML}/${Target_Tuple}/lib/Release/libsfml-graphics-s.a)
	Ios_dk_libDebug			(${SFML}/${Target_Tuple}/lib/Debug/libsfml-graphics-s-d.a)
	Ios_dk_libRelease		(${SFML}/${Target_Tuple}/lib/Release/libsfml-graphics-s.a)
	Linux_dk_libDebug		(${SFML_Debug_Dir}/lib/libsfml-graphics-s-d.a)
	Linux_dk_libRelease		(${SFML_Release_Dir}/lib/libsfml-graphics-s.a)
	Mac_dk_libDebug			(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/libsfml-graphics-s-d.a)
	Mac_dk_libRelease		(${SFML}/${Target_Tuple}/lib/${Release_Dir}/libsfml-graphics-s.a)
	Raspberry_dk_libDebug	(${SFML_Debug_Dir}/lib/libsfml-graphics-s-d.a)
	Raspberry_dk_libRelease	(${SFML_Release_Dir}/lib/libsfml-graphics-s.a)
	Windows_dk_libDebug			(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/sfml-graphics-s-d.lib)
	Windows_dk_libRelease		(${SFML}/${Target_Tuple}/lib/${Release_Dir}/sfml-graphics-s.lib)
endif()

if(sfml_sfml-main)
	Windows_dk_libDebug			(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/sfml-main-d.lib)
	Windows_dk_libRelease		(${SFML}/${Target_Tuple}/lib/${Release_Dir}/sfml-main.lib)
endif()

if(sfml_sfml-network)
	Android_dk_libDebug		(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/libsfml-network-s-d.a)
	Android_dk_libRelease	(${SFML}/${Target_Tuple}/lib/${Release_Dir}/libsfml-network-s.a)
	Emscripten_dk_libDebug	(${SFML_Debug_Dir}/lib/libsfml-network-s-d.a)
	Emscripten_dk_libRelease(${SFML_Release_Dir}/lib/libsfml-network-s.a)
	Iossim_dk_libDebug		(${SFML}/${Target_Tuple}/lib/Debug/libsfml-network-s-d.a)
	Iossim_dk_libRelease	(${SFML}/${Target_Tuple}/lib/Release/libsfml-network-s.a)
	Ios_dk_libDebug			(${SFML}/${Target_Tuple}/lib/Debug/libsfml-network-s-d.a)
	Ios_dk_libRelease		(${SFML}/${Target_Tuple}/lib/Release/libsfml-network-s.a)
	Linux_dk_libDebug		(${SFML_Debug_Dir}/lib/libsfml-network-s-d.a)
	Linux_dk_libRelease		(${SFML_Release_Dir}/lib/libsfml-network-s.a)
	Mac_dk_libDebug			(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/libsfml-network-s-d.a)
	Mac_dk_libRelease		(${SFML}/${Target_Tuple}/lib/${Release_Dir}/libsfml-network-s.a)
	Raspberry_dk_libDebug	(${SFML_Debug_Dir}/lib/libsfml-network-s-d.a)
	Raspberry_dk_libRelease	(${SFML_Release_Dir}/lib/libsfml-network-s.a)
	Windows_dk_libDebug			(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/sfml-network-s-d.lib)
	Windows_dk_libRelease		(${SFML}/${Target_Tuple}/lib/${Release_Dir}/sfml-network-s.lib)
endif()

if(sfml_sfml-system)
	Android_dk_libDebug		(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/libsfml-system-s-d.a)
	Android_dk_libRelease	(${SFML}/${Target_Tuple}/lib/${Release_Dir}/libsfml-system-s.a)
	Emscripten_dk_libDebug	(${SFML_Debug_Dir}/lib/libsfml-system-s-d.a)
	Emscripten_dk_libRelease(${SFML_Release_Dir}/lib/libsfml-system-s.a)
	Iossim_dk_libDebug		(${SFML}/${Target_Tuple}/lib/Debug/libsfml-system-s-d.a)
	Iossim_dk_libRelease	(${SFML}/${Target_Tuple}/lib/Release/libsfml-system-s.a)
	Ios_dk_libDebug			(${SFML}/${Target_Tuple}/lib/Debug/libsfml-system-s-d.a)
	Ios_dk_libRelease		(${SFML}/${Target_Tuple}/lib/Release/libsfml-system-s.a)
	Linux_dk_libDebug		(${SFML_Debug_Dir}/lib/libsfml-system-s-d.a)
	Linux_dk_libRelease		(${SFML_Release_Dir}/lib/libsfml-system-s.a)
	Mac_dk_libDebug			(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/libsfml-system-s-d.a)
	Mac_dk_libRelease		(${SFML}/${Target_Tuple}/lib/${Release_Dir}/libsfml-system-s.a)
	Raspberry_dk_libDebug	(${SFML_Debug_Dir}/lib/libsfml-system-s-d.a)
	Raspberry_dk_libRelease	(${SFML_Release_Dir}/lib/libsfml-system-s.a)
	Windows_dk_libDebug			(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/sfml-system-s-d.lib)
	Windows_dk_libRelease		(${SFML}/${Target_Tuple}/lib/${Release_Dir}/sfml-system-s.lib)
endif()

if(sfml_sfml-window)
	Android_dk_libDebug		(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/libsfml-window-s-d.a)
	Android_dk_libRelease	(${SFML}/${Target_Tuple}/lib/${Release_Dir}/libsfml-window-s.a)
	Emscripten_dk_libDebug	(${SFML_Debug_Dir}/lib/libsfml-window-s-d.a)
	Emscripten_dk_libRelease(${SFML_Release_Dir}/lib/libsfml-window-s.a)
	Iossim_dk_libDebug		(${SFML}/${Target_Tuple}/lib/Debug/libsfml-window-s-d.a)
	Iossim_dk_libRelease	(${SFML}/${Target_Tuple}/lib/Release/libsfml-window-s.a)
	Ios_dk_libDebug			(${SFML}/${Target_Tuple}/lib/Debug/libsfml-window-s-d.a)
	Ios_dk_libRelease		(${SFML}/${Target_Tuple}/lib/Release/libsfml-window-s.a)
	Linux_dk_libDebug		(${SFML_Debug_Dir}/lib/libsfml-window-s-d.a)
	Linux_dk_libRelease		(${SFML_Release_Dir}/lib/libsfml-window-s.a)
	Mac_dk_libDebug			(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/libsfml-window-s-d.a)
	Mac_dk_libRelease		(${SFML}/${Target_Tuple}/lib/${Release_Dir}/libsfml-window-s.a)
	Raspberry_dk_libDebug	(${SFML_Debug_Dir}/lib/libsfml-window-s-d.a)
	Raspberry_dk_libRelease	(${SFML_Release_Dir}/lib/libsfml-window-s.a)
	Windows_dk_libDebug			(${SFML}/${Target_Tuple}/lib/${Debug_Dir}/sfml-window-s-d.lib)
	Windows_dk_libRelease		(${SFML}/${Target_Tuple}/lib/${Release_Dir}/sfml-window-s.lib)
endif()


### 3RDPARTY LINK ###
Windows_dk_set(SFML_CMAKE
	-DSFML_INCLUDE_DIR=${SFML}/include
	-DSFML_AUDIO_LIBRARY_DEBUG=${SFML}/${Target_Tuple}/lib/${Debug_Dir}/sfml-audio-s-d.lib
	-DSFML_AUDIO_LIBRARY_RELEASE=${SFML}/${Target_Tuple}/lib/${Release_Dir}/sfml-audio-s.lib
	-DSFML_GRAPHICS_LIBRARY_DEBUG=${SFML}/${Target_Tuple}/lib/${Debug_Dir}/sfml-graphics-s-d.lib
	-DSFML_GRAPHICS_LIBRARY_RELEASE=${SFML}/${Target_Tuple}/lib/${Release_Dir}/sfml-graphics-s.lib
	-DSFML_MAIN_LIBRARY_DEBUG=${SFML}/${Target_Tuple}/lib/${Debug_Dir}/sfml-main-d.lib
	-DSFML_MAIN_LIBRARY_RELEASE=${SFML}/${Target_Tuple}/lib/${Release_Dir}/sfml-main.lib
	-DSFML_SYSTEM_LIBRARY_DEBUG=${SFML}/${Target_Tuple}/lib/${Debug_Dir}/sfml-system-s-d.lib
	-DSFML_SYSTEM_LIBRARY_RELEASE=${SFML}/${Target_Tuple}/lib/${Release_Dir}/sfml-system-s.lib
	-DSFML_WINDOW_LIBRARY_DEBUG=${SFML}/${Target_Tuple}/lib/${Debug_Dir}/sfml-window-s-d.lib
	-DSFML_WINDOW_LIBRARY_RELEASE=${SFML}/${Target_Tuple}/lib/${Release_Dir}/sfml-window-s.lib)


### GENERATE ###
Android_dk_configure	(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
Emscripten_dk_configure	(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
Iossim_dk_configure		(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
Ios_dk_configure		(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
Linux_dk_configure		(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
Mac_dk_configure		(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} -DSFML_OS_MACOSX=1)
Raspberry_dk_configure	(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
Windows_dk_configure		(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} -DSFML_OS_WINDOWS=1 -DSFML_USE_STATIC_STD_LIBS=TRUE)


### COMPILE ###
dk_build()
