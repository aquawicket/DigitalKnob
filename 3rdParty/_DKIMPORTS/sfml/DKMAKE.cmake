# https://github.com/SFML/SFML
# https://www.sfml-dev.org
# https://github.com/SFML/SFML/archive/refs/heads/master.zip
# https://www.sfml-dev.org/files/SFML-2.5.1-sources.zip


### DEPEND ###
WIN_dk_depend(opengl)
WIN_dk_depend(winmm.lib)
MAC_dk_depend(core_foundation)
MAC_dk_depend(cocoa)
MAC_dk_depend(carbon)
MAC_dk_depend(audio_toolbox)
MAC_dk_depend(audiounit)
MAC_dk_depend(core_audio)
MAC_dk_depend(core_video)
MAC_dk_depend(iokit)
MAC_dk_depend(opengl)
MAC_dk_depend(force_feedback)
MAC_dk_depend(appkit)
if(IOS OR IOSSIM)
	dk_depend(audio_toolbox)
	dk_depend(av_foundation)
	dk_depend(core_audio)
	dk_depend(core_graphics)
	dk_depend(core_motion)
	dk_depend(foundation)
	dk_depend(game_controller)
	dk_depend(quartz_core)
	dk_depend(uikit)
	dk_depend(opengles)
endif()
if(LINUX OR RASPBERRY)
	dk_depend(build-essential)
	dk_depend(libxrandr-dev)
	dk_depend(libudev-dev)
	dk_depend(libgtk2.0-dev)
	dk_depend(libx11-dev)
	dk_depend(libxcursor-dev)
	dk_depend(libsndfile1-dev)
	dk_depend(mesa-common-dev)
	dk_depend(openal)
	dk_depend(opengl)
endif()
ANDROID_dk_depend(freetype)
dk_depend(openal)
dk_depend(flac)
dk_depend(ogg)
dk_depend(vorbis)
dk_depend(libjpeg-turbo)


### IMPORT ###
#dk_import(https://github.com/SFML/SFML/archive/a733e4cd7e0056922e4f74f1932749b4d6a5744d.zip PATCH)
dk_import(https://github.com/SFML/SFML.git PATCH)


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
	WIN_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-audio-s-d.lib)
	WIN_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-audio-s.lib)
	MAC_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-audio-s-d.a)
	MAC_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-audio-s.a)
	IOS_dk_libDebug			(${SFML}/${OS}/lib/Debug/libsfml-audio-s-d.a)
	IOS_dk_libRelease		(${SFML}/${OS}/lib/Release/libsfml-audio-s.a)
	IOSSIM_dk_libDebug		(${SFML}/${OS}/lib/Debug/libsfml-audio-s-d.a)
	IOSSIM_dk_libRelease	(${SFML}/${OS}/lib/Release/libsfml-audio-s.a)
	LINUX_dk_libDebug		(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-audio-s-d.a)
	LINUX_dk_libRelease		(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-audio-s.a)
	RASPBERRY_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-audio-s-d.a)
	RASPBERRY_dk_libRelease	(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-audio-s.a)
	ANDROID_dk_libDebug		(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-audio-s-d.a)
	ANDROID_dk_libRelease	(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-audio-s.a)
endif()

if(sfml_sfml-graphics)
	WIN_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-graphics-s-d.lib)
	WIN_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-graphics-s.lib)
	MAC_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-graphics-s-d.a)
	MAC_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-graphics-s.a)
	IOS_dk_libDebug			(${SFML}/${OS}/lib/Debug/libsfml-graphics-s-d.a)
	IOS_dk_libRelease		(${SFML}/${OS}/lib/Release/libsfml-graphics-s.a)
	IOSSIM_dk_libDebug		(${SFML}/${OS}/lib/Debug/libsfml-graphics-s-d.a)
	IOSSIM_dk_libRelease	(${SFML}/${OS}/lib/Release/libsfml-graphics-s.a)
	LINUX_dk_libDebug		(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-graphics-s-d.a)
	LINUX_dk_libRelease		(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-graphics-s.a)
	RASPBERRY_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-graphics-s-d.a)
	RASPBERRY_dk_libRelease	(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-graphics-s.a)
	ANDROID_dk_libDebug		(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-graphics-s-d.a)
	ANDROID_dk_libRelease	(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-graphics-s.a)
endif()

if(sfml_sfml-main)
	WIN_dk_libDebug		(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-main-d.lib)
	WIN_dk_libRelease	(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-main.lib)
endif()

if(sfml_sfml-network)
	WIN_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-network-s-d.lib)
	WIN_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-network-s.lib)
	MAC_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-network-s-d.a)
	MAC_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-network-s.a)
	IOS_dk_libDebug			(${SFML}/${OS}/lib/Debug/libsfml-network-s-d.a)
	IOS_dk_libRelease		(${SFML}/${OS}/lib/Release/libsfml-network-s.a)
	IOSSIM_dk_libDebug		(${SFML}/${OS}/lib/Debug/libsfml-network-s-d.a)
	IOSSIM_dk_libRelease	(${SFML}/${OS}/lib/Release/libsfml-network-s.a)
	LINUX_dk_libDebug		(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-network-s-d.a)
	LINUX_dk_libRelease		(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-network-s.a)
	RASPBERRY_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-network-s-d.a)
	RASPBERRY_dk_libRelease	(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-network-s.a)
	ANDROID_dk_libDebug		(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-network-s-d.a)
	ANDROID_dk_libRelease	(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-network-s.a)
endif()

if(sfml_sfml-system)
	WIN_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-system-s-d.lib)
	WIN_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-system-s.lib)
	MAC_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-system-s-d.a)
	MAC_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-system-s.a)
	IOS_dk_libDebug			(${SFML}/${OS}/lib/Debug/libsfml-system-s-d.a)
	IOS_dk_libRelease		(${SFML}/${OS}/lib/Release/libsfml-system-s.a)
	IOSSIM_dk_libDebug		(${SFML}/${OS}/lib/Debug/libsfml-system-s-d.a)
	IOSSIM_dk_libRelease	(${SFML}/${OS}/lib/Release/libsfml-system-s.a)
	LINUX_dk_libDebug		(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-system-s-d.a)
	LINUX_dk_libRelease		(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-system-s.a)
	RASPBERRY_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-system-s-d.a)
	RASPBERRY_dk_libRelease	(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-system-s.a)
	ANDROID_dk_libDebug		(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-system-s-d.a)
	ANDROID_dk_libRelease	(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-system-s.a)
endif()

if(sfml_sfml-window)
	WIN_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-window-s-d.lib)
	WIN_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-window-s.lib)
	MAC_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-window-s-d.a)
	MAC_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-window-s.a)
	IOS_dk_libDebug			(${SFML}/${OS}/lib/Debug/libsfml-window-s-d.a)
	IOS_dk_libRelease		(${SFML}/${OS}/lib/Release/libsfml-window-s.a)
	IOSSIM_dk_libDebug		(${SFML}/${OS}/lib/Debug/libsfml-window-s-d.a)
	IOSSIM_dk_libRelease	(${SFML}/${OS}/lib/Release/libsfml-window-s.a)
	LINUX_dk_libDebug		(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-window-s-d.a)
	LINUX_dk_libRelease		(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-window-s.a)
	RASPBERRY_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-window-s-d.a)
	RASPBERRY_dk_libRelease	(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-window-s.a)
	ANDROID_dk_libDebug		(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-window-s-d.a)
	ANDROID_dk_libRelease	(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-window-s.a)
endif()


### 3RDPARTY LINK ###
WIN_dk_set(SFML_CMAKE
	-DSFML_INCLUDE_DIR=${SFML}/include
	-DSFML_MAIN_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-main-d.lib
	-DSFML_MAIN_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-main.lib
	-DSFML_SYSTEM_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-system-s-d.lib
	-DSFML_SYSTEM_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-system-s.lib
	-DSFML_WINDOW_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-window-s-d.lib
	-DSFML_WINDOW_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-window-s.lib
	-DSFML_GRAPHICS_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-graphics-s-d.lib
	-DSFML_GRAPHICS_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-graphics-s.lib
	-DSFML_AUDIO_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-audio-s-d.lib
	-DSFML_AUDIO_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-audio-s.lib)


### GENERATE ###
WIN_dk_queueCommand			(${DKCMAKE_BUILD} ${LIBJPEG-TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} -DSFML_OS_WINDOWS=1 -DSFML_USE_STATIC_STD_LIBS=TRUE ${SFML})
MAC_dk_queueCommand			(${DKCMAKE_BUILD} ${LIBJPEG-TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} -DSFML_OS_MACOSX=1 ${SFML})
IOS_dk_queueCommand			(${DKCMAKE_BUILD} ${LIBJPEG-TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${SFML})
IOSSIM_dk_queueCommand		(${DKCMAKE_BUILD} ${LIBJPEG-TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${SFML})
LINUX_dk_queueCommand		(${DKCMAKE_BUILD} ${LIBJPEG-TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${SFML})
RASPBERRY_dk_queueCommand	(${DKCMAKE_BUILD} ${LIBJPEG-TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${SFML})
ANDROID_dk_queueCommand		(${DKCMAKE_BUILD} ${LIBJPEG-TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${SFML})


### COMPILE ###
dk_build(${SFML})
