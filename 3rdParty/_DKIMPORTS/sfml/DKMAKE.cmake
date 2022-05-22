# https://github.com/SFML/SFML
# https://www.sfml-dev.org
#
# https://github.com/SFML/SFML/archive/refs/heads/master.zip
# https://www.sfml-dev.org/files/SFML-2.5.1-sources.zip

### DEPENDS ###
if(WIN)
	DKDEPEND(opengl)
	DKDEPEND(winmm.lib)
endif()
if(MAC)
	DKDEPEND(core_foundation)
	DKDEPEND(cocoa)
	DKDEPEND(carbon)
	DKDEPEND(audio_toolbox)
	DKDEPEND(audiounit)
	DKDEPEND(core_audio)
	DKDEPEND(core_video)
	DKDEPEND(iokit)
	DKDEPEND(opengl)
	DKDEPEND(force_feedback)
	DKDEPEND(appkit)
endif()
if(IOS OR IOSSIM)
	DKDEPEND(audio_toolbox)
	DKDEPEND(av_foundation)
	DKDEPEND(core_audio)
	DKDEPEND(core_graphics)
	DKDEPEND(core_motion)
	DKDEPEND(foundation)
	DKDEPEND(game_controller)
	DKDEPEND(quartz_core)
	DKDEPEND(uikit)
	DKDEPEND(opengles)
endif()
if(LINUX OR RASPBERRY)
	DKDEPEND(build-essential)
	DKDEPEND(libxrandr-dev)
	DKDEPEND(libudev-dev)
	DKDEPEND(libgtk2.0-dev)
	DKDEPEND(libx11-dev)
	DKDEPEND(libxcursor-dev)
	DKDEPEND(libsndfile1-dev)
	DKDEPEND(mesa-common-dev)
	DKDEPEND(openal)
	DKDEPEND(opengl)
endif()
if(ANDROID)
	DKDEPEND(freetype)
endif()
DKDEPEND(openal)
DKDEPEND(flac)
DKDEPEND(ogg)
DKDEPEND(vorbis)
DKDEPEND(libjpeg-turbo)


DKGITCLONE(https://github.com/SFML/SFML.git PATCH)
#DKIMPORT(https://github.com/SFML/SFML/archive/c7705a8d9a79bb2c8868518c32ae54f14220793c.zip PATCH)
#DKIMPORT(https://github.com/SFML/SFML/archive/a733e4cd7e0056922e4f74f1932749b4d6a5744d.zip)
#DKSET(SFML_VERSION master)
#DKSET(SFML_NAME SFML-${SFML_VERSION})
#DKSET(SFML ${3RDPARTY}/${SFML_NAME})
#DKINSTALL(${SFML_DL} sfml ${SFML})


### LINK ###
DKDEFINE(SFML_STATIC)
DKINCLUDE(${SFML}/include)
dk_addTarget(sfml sfml-audio)
dk_addTarget(sfml sfml-graphics)
dk_addTarget(sfml sfml-main)
dk_addTarget(sfml sfml-network)
dk_addTarget(sfml sfml-system)
dk_addTarget(sfml sfml-window)

if(sfml_sfml-audio)
	WIN_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-audio-s-d.lib)
	WIN_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-audio-s.lib)
	MAC_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-audio-s-d.a)
	MAC_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-audio-s.a)
	IOS_DEBUG_DKLIB(${SFML}/${OS}/lib/Debug/libsfml-audio-s-d.a)
	IOS_RELEASE_DKLIB(${SFML}/${OS}/lib/Release/libsfml-audio-s.a)
	IOSSIM_DEBUG_DKLIB(${SFML}/${OS}/lib/Debug/libsfml-audio-s-d.a)
	IOSSIM_RELEASE_DKLIB(${SFML}/${OS}/lib/Release/libsfml-audio-s.a)
	LINUX_DEBUG_DKLIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-audio-s-d.a)
	LINUX_RELEASE_DKLIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-audio-s.a)
	RASPBERRY_DEBUG_DKLIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-audio-s-d.a)
	RASPBERRY_RELEASE_DKLIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-audio-s.a)
	ANDROID_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-audio-s-d.a)
	ANDROID_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-audio-s.a)
endif()

if(sfml_sfml-graphics)
	WIN_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-graphics-s-d.lib)
	WIN_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-graphics-s.lib)
	MAC_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-graphics-s-d.a)
	MAC_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-graphics-s.a)
	IOS_DEBUG_DKLIB(${SFML}/${OS}/lib/Debug/libsfml-graphics-s-d.a)
	IOS_RELEASE_DKLIB(${SFML}/${OS}/lib/Release/libsfml-graphics-s.a)
	IOSSIM_DEBUG_DKLIB(${SFML}/${OS}/lib/Debug/libsfml-graphics-s-d.a)
	IOSSIM_RELEASE_DKLIB(${SFML}/${OS}/lib/Release/libsfml-graphics-s.a)
	LINUX_DEBUG_DKLIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-graphics-s-d.a)
	LINUX_RELEASE_DKLIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-graphics-s.a)
	RASPBERRY_DEBUG_DKLIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-graphics-s-d.a)
	RASPBERRY_RELEASE_DKLIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-graphics-s.a)
	ANDROID_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-graphics-s-d.a)
	ANDROID_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-graphics-s.a)
endif()

if(sfml_sfml-main)
	WIN_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-main-d.lib)
	WIN_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-main.lib)
endif()

if(sfml_sfml-network)
	WIN_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-network-s-d.lib)
	WIN_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-network-s.lib)
	MAC_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-network-s-d.a)
	MAC_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-network-s.a)
	IOS_DEBUG_DKLIB(${SFML}/${OS}/lib/Debug/libsfml-network-s-d.a)
	IOS_RELEASE_DKLIB(${SFML}/${OS}/lib/Release/libsfml-network-s.a)
	IOSSIM_DEBUG_DKLIB(${SFML}/${OS}/lib/Debug/libsfml-network-s-d.a)
	IOSSIM_RELEASE_DKLIB(${SFML}/${OS}/lib/Release/libsfml-network-s.a)
	LINUX_DEBUG_DKLIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-network-s-d.a)
	LINUX_RELEASE_DKLIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-network-s.a)
	RASPBERRY_DEBUG_DKLIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-network-s-d.a)
	RASPBERRY_RELEASE_DKLIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-network-s.a)
	ANDROID_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-network-s-d.a)
	ANDROID_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-network-s.a)
endif()

if(sfml_sfml-system)
	WIN_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-system-s-d.lib)
	WIN_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-system-s.lib)
	MAC_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-system-s-d.a)
	MAC_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-system-s.a)
	IOS_DEBUG_DKLIB(${SFML}/${OS}/lib/Debug/libsfml-system-s-d.a)
	IOS_RELEASE_DKLIB(${SFML}/${OS}/lib/Release/libsfml-system-s.a)
	IOSSIM_DEBUG_DKLIB(${SFML}/${OS}/lib/Debug/libsfml-system-s-d.a)
	IOSSIM_RELEASE_DKLIB(${SFML}/${OS}/lib/Release/libsfml-system-s.a)
	LINUX_DEBUG_DKLIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-system-s-d.a)
	LINUX_RELEASE_DKLIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-system-s.a)
	RASPBERRY_DEBUG_DKLIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-system-s-d.a)
	RASPBERRY_RELEASE_DKLIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-system-s.a)
	ANDROID_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-system-s-d.a)
	ANDROID_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-system-s.a)
endif()

if(sfml_sfml-window)
	WIN_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-window-s-d.lib)
	WIN_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-window-s.lib)
	MAC_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-window-s-d.a)
	MAC_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-window-s.a)
	IOS_DEBUG_DKLIB(${SFML}/${OS}/lib/Debug/libsfml-window-s-d.a)
	IOS_RELEASE_DKLIB(${SFML}/${OS}/lib/Release/libsfml-window-s.a)
	IOSSIM_DEBUG_DKLIB(${SFML}/${OS}/lib/Debug/libsfml-window-s-d.a)
	IOSSIM_RELEASE_DKLIB(${SFML}/${OS}/lib/Release/libsfml-window-s.a)
	LINUX_DEBUG_DKLIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-window-s-d.a)
	LINUX_RELEASE_DKLIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-window-s.a)
	RASPBERRY_DEBUG_DKLIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-window-s-d.a)
	RASPBERRY_RELEASE_DKLIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-window-s.a)
	ANDROID_DEBUG_DKLIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-window-s-d.a)
	ANDROID_RELEASE_DKLIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-window-s.a)
endif()


### 3RDPARTY LINK ###
WIN_DKSET(SFML_CMAKE
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

### COMPILE ###
DKSETPATH(${SFML}/${BUILD_DIR})


WIN_DKQCOMMAND(${DKCMAKE_BUILD} -DSFML_OS_WINDOWS=1 -DBUILD_SHARED_LIBS=FALSE ${JPEG_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${SFML})
WIN_VS(${SFML_NAME} SFML.sln)

MAC_DKQCOMMAND(${DKCMAKE_BUILD} -DSFML_OS_MACOSX=1 -DBUILD_SHARED_LIBS=FALSE ${JPEG_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${SFML})
MAC_XCODE(${SFML_NAME})

IOS_DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_SHARED_LIBS=FALSE ${JPEG_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${SFML})
IOS_XCODE(${SFML_NAME})

IOSSIM_DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_SHARED_LIBS=FALSE ${JPEG_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${SFML})
IOSSIM_XCODE(${SFML_NAME})

LINUX_DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_SHARED_LIBS=FALSE ${JPEG_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${SFML})
LINUX_DKQCOMMAND(make)

RASPBERRY_DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_SHARED_LIBS=FALSE ${JPEG_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${SFML})
RASPBERRY_DKQCOMMAND(make)

ANDROID_DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_SHARED_LIBS=FALSE ${JPEG_CMAKE} ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${FLAC_CMAKE} ${SFML})
ANDROID_VS(${SFML_NAME} SFML.sln)
