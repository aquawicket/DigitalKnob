# https://github.com/SFML/SFML
# https://www.sfml-dev.org
# https://github.com/SFML/SFML/archive/refs/heads/master.zip
# https://www.sfml-dev.org/files/SFML-2.5.1-sources.zip


### DEPEND ###
ANDROID_dk_depend(freetype)
if(IOS OR IOSSIM)
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
MAC_dk_depend(appkit)
MAC_dk_depend(audio_toolbox)
MAC_dk_depend(audiounit)
MAC_dk_depend(carbon)
MAC_dk_depend(cocoa)
MAC_dk_depend(core_audio)
MAC_dk_depend(core_foundation)
MAC_dk_depend(core_video)
MAC_dk_depend(force_feedback)
MAC_dk_depend(iokit)
MAC_dk_depend(opengl)
if(LINUX OR RASPBERRY)
	dk_depend(build-essential)
	dk_depend(libgtk2.0-dev)
	dk_depend(libsndfile1-dev)
	dk_depend(libudev-dev)
	dk_depend(libx11-dev)
	dk_depend(libxcursor-dev)
	dk_depend(libxrandr-dev)
	dk_depend(mesa-common-dev)
	dk_depend(openal)
	dk_depend(opengl)
endif()
WIN_dk_depend(opengl)
WIN_dk_depend(winmm.lib)
dk_depend(flac)
dk_depend(libjpeg-turbo)
dk_depend(ogg)
dk_depend(openal)
dk_depend(vorbis)


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
	ANDROID_dk_libDebug		(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-audio-s-d.a)
	ANDROID_dk_libRelease	(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-audio-s.a)
	EMSCRIPTEN_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-audio-s-d.a)
	EMSCRIPTEN_dk_libRelease(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-audio-s.a)
	IOSSIM_dk_libDebug		(${SFML}/${OS}/lib/Debug/libsfml-audio-s-d.a)
	IOSSIM_dk_libRelease	(${SFML}/${OS}/lib/Release/libsfml-audio-s.a)
	IOS_dk_libDebug			(${SFML}/${OS}/lib/Debug/libsfml-audio-s-d.a)
	IOS_dk_libRelease		(${SFML}/${OS}/lib/Release/libsfml-audio-s.a)
	LINUX_dk_libDebug		(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-audio-s-d.a)
	LINUX_dk_libRelease		(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-audio-s.a)
	MAC_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-audio-s-d.a)
	MAC_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-audio-s.a)
	RASPBERRY_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-audio-s-d.a)
	RASPBERRY_dk_libRelease	(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-audio-s.a)
	WIN_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-audio-s-d.lib)
	WIN_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-audio-s.lib)
endif()

if(sfml_sfml-graphics)
	ANDROID_dk_libDebug		(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-graphics-s-d.a)
	ANDROID_dk_libRelease	(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-graphics-s.a)
	EMSCRIPTEN_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-graphics-s-d.a)
	EMSCRIPTEN_dk_libRelease(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-graphics-s.a)
	IOSSIM_dk_libDebug		(${SFML}/${OS}/lib/Debug/libsfml-graphics-s-d.a)
	IOSSIM_dk_libRelease	(${SFML}/${OS}/lib/Release/libsfml-graphics-s.a)
	IOS_dk_libDebug			(${SFML}/${OS}/lib/Debug/libsfml-graphics-s-d.a)
	IOS_dk_libRelease		(${SFML}/${OS}/lib/Release/libsfml-graphics-s.a)
	LINUX_dk_libDebug		(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-graphics-s-d.a)
	LINUX_dk_libRelease		(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-graphics-s.a)
	MAC_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-graphics-s-d.a)
	MAC_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-graphics-s.a)
	RASPBERRY_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-graphics-s-d.a)
	RASPBERRY_dk_libRelease	(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-graphics-s.a)
	WIN_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-graphics-s-d.lib)
	WIN_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-graphics-s.lib)
endif()

if(sfml_sfml-main)
	WIN_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-main-d.lib)
	WIN_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-main.lib)
endif()

if(sfml_sfml-network)
	ANDROID_dk_libDebug		(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-network-s-d.a)
	ANDROID_dk_libRelease	(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-network-s.a)
	EMSCRIPTEN_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-network-s-d.a)
	EMSCRIPTEN_dk_libRelease(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-network-s.a)
	IOSSIM_dk_libDebug		(${SFML}/${OS}/lib/Debug/libsfml-network-s-d.a)
	IOSSIM_dk_libRelease	(${SFML}/${OS}/lib/Release/libsfml-network-s.a)
	IOS_dk_libDebug			(${SFML}/${OS}/lib/Debug/libsfml-network-s-d.a)
	IOS_dk_libRelease		(${SFML}/${OS}/lib/Release/libsfml-network-s.a)
	LINUX_dk_libDebug		(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-network-s-d.a)
	LINUX_dk_libRelease		(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-network-s.a)
	MAC_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-network-s-d.a)
	MAC_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-network-s.a)
	RASPBERRY_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-network-s-d.a)
	RASPBERRY_dk_libRelease	(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-network-s.a)
	WIN_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-network-s-d.lib)
	WIN_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-network-s.lib)
endif()

if(sfml_sfml-system)
	ANDROID_dk_libDebug		(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-system-s-d.a)
	ANDROID_dk_libRelease	(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-system-s.a)
	EMSCRIPTEN_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-system-s-d.a)
	EMSCRIPTEN_dk_libRelease(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-system-s.a)
	IOSSIM_dk_libDebug		(${SFML}/${OS}/lib/Debug/libsfml-system-s-d.a)
	IOSSIM_dk_libRelease	(${SFML}/${OS}/lib/Release/libsfml-system-s.a)
	IOS_dk_libDebug			(${SFML}/${OS}/lib/Debug/libsfml-system-s-d.a)
	IOS_dk_libRelease		(${SFML}/${OS}/lib/Release/libsfml-system-s.a)
	LINUX_dk_libDebug		(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-system-s-d.a)
	LINUX_dk_libRelease		(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-system-s.a)
	MAC_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-system-s-d.a)
	MAC_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-system-s.a)
	RASPBERRY_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-system-s-d.a)
	RASPBERRY_dk_libRelease	(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-system-s.a)
	WIN_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-system-s-d.lib)
	WIN_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-system-s.lib)
endif()

if(sfml_sfml-window)
	ANDROID_dk_libDebug		(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-window-s-d.a)
	ANDROID_dk_libRelease	(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-window-s.a)
	EMSCRIPTEN_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-window-s-d.a)
	EMSCRIPTEN_dk_libRelease(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-window-s.a)
	IOSSIM_dk_libDebug		(${SFML}/${OS}/lib/Debug/libsfml-window-s-d.a)
	IOSSIM_dk_libRelease	(${SFML}/${OS}/lib/Release/libsfml-window-s.a)
	IOS_dk_libDebug			(${SFML}/${OS}/lib/Debug/libsfml-window-s-d.a)
	IOS_dk_libRelease		(${SFML}/${OS}/lib/Release/libsfml-window-s.a)
	LINUX_dk_libDebug		(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-window-s-d.a)
	LINUX_dk_libRelease		(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-window-s.a)
	MAC_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-window-s-d.a)
	MAC_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-window-s.a)
	RASPBERRY_dk_libDebug	(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-window-s-d.a)
	RASPBERRY_dk_libRelease	(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-window-s.a)
	WIN_dk_libDebug			(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-window-s-d.lib)
	WIN_dk_libRelease		(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-window-s.lib)
endif()


### 3RDPARTY LINK ###
WIN_dk_set(SFML_CMAKE
	-DSFML_INCLUDE_DIR=${SFML}/include
	-DSFML_AUDIO_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-audio-s-d.lib
	-DSFML_AUDIO_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-audio-s.lib
	-DSFML_GRAPHICS_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-graphics-s-d.lib
	-DSFML_GRAPHICS_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-graphics-s.lib
	-DSFML_MAIN_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-main-d.lib
	-DSFML_MAIN_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-main.lib
	-DSFML_SYSTEM_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-system-s-d.lib
	-DSFML_SYSTEM_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-system-s.lib
	-DSFML_WINDOW_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-window-s-d.lib
	-DSFML_WINDOW_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-window-s.lib)


### GENERATE ###
ANDROID_dk_configure	(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
EMSCRIPTEN_dk_configure	(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
IOSSIM_dk_configure		(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
IOS_dk_configure		(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
LINUX_dk_configure		(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
MAC_dk_configure		(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} -DSFML_OS_MACOSX=1)
RASPBERRY_dk_configure	(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE})
WIN_dk_configure		(${SFML} ${LIBJPEG_TURBO_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} -DSFML_OS_WINDOWS=1 -DSFML_USE_STATIC_STD_LIBS=TRUE)


### COMPILE ###
dk_build(${SFML})
