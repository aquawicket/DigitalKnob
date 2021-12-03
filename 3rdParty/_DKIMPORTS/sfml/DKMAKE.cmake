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
if(LINUX OR RASPBERRY)
	DKDEPEND(build-essential)
	DKDEPEND(libxrandr-dev)
	DKDEPEND(libudev-dev)
	DKDEPEND(libgtk2.0-dev)
	DKDEPEND(libx11-dev)
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
DKDEPEND(libogg)
DKDEPEND(libvorbis)
DKDEPEND(libjpeg-turbo)


### VERSION ### 
DKSET(SFML_VERSION 2.5.1)
DKSET(SFML_NAME SFML-${SFML_VERSION})
DKSET(SFML_DL https://www.sfml-dev.org/files/${SFML_NAME}-sources.zip)
DKSET(SFML ${3RDPARTY}/${SFML_NAME})


### INSTALL ###
DKINSTALL(${SFML_DL} sfml ${SFML} NOPATCH)


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
	WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-audio-s-d.lib)
	WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-audio-s.lib)
	MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-audio-s-d.a)
	MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-audio-s.a)
	IOS_DEBUG_LIB(${SFML}/${OS}/lib/Debug/libsfml-audio-s-d.a)
	IOS_RELEASE_LIB(${SFML}/${OS}/lib/Release/libsfml-audio-s.a)
	IOSSIM_DEBUG_LIB(${SFML}/${OS}/lib/Debug/libsfml-audio-s-d.a)
	IOSSIM_RELEASE_LIB(${SFML}/${OS}/lib/Release/libsfml-audio-s.a)
	LINUX_DEBUG_LIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-audio-s-d.a)
	LINUX_RELEASE_LIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-audio-s.a)
	RASPBERRY_DEBUG_LIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-audio-s-d.a)
	RASPBERRY_RELEASE_LIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-audio-s.a)
	ANDROID_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-audio-s-d.a)
	ANDROID_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-audio-s.a)
endif()

if(sfml_sfml-graphics)
	WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-graphics-s-d.lib)
	WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-graphics-s.lib)
	MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-graphics-s-d.a)
	MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-graphics-s.a)
	IOS_DEBUG_LIB(${SFML}/${OS}/lib/Debug/libsfml-graphics-s-d.a)
	IOS_RELEASE_LIB(${SFML}/${OS}/lib/Release/libsfml-graphics-s.a)
	IOSSIM_DEBUG_LIB(${SFML}/${OS}/lib/Debug/libsfml-graphics-s-d.a)
	IOSSIM_RELEASE_LIB(${SFML}/${OS}/lib/Release/libsfml-graphics-s.a)
	LINUX_DEBUG_LIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-graphics-s-d.a)
	LINUX_RELEASE_LIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-graphics-s.a)
	RASPBERRY_DEBUG_LIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-graphics-s-d.a)
	RASPBERRY_RELEASE_LIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-graphics-s.a)
	ANDROID_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-graphics-s-d.a)
	ANDROID_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-graphics-s.a)
endif()

if(sfml_sfml-main)
	WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-main-d.lib)
	WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-main.lib)
endif()

if(sfml_sfml-network)
	WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-network-s-d.lib)
	WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-network-s.lib)
	MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-network-s-d.a)
	MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-network-s.a)
	IOS_DEBUG_LIB(${SFML}/${OS}/lib/Debug/libsfml-network-s-d.a)
	IOS_RELEASE_LIB(${SFML}/${OS}/lib/Release/libsfml-network-s.a)
	IOSSIM_DEBUG_LIB(${SFML}/${OS}/lib/Debug/libsfml-network-s-d.a)
	IOSSIM_RELEASE_LIB(${SFML}/${OS}/lib/Release/libsfml-network-s.a)
	LINUX_DEBUG_LIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-network-s-d.a)
	LINUX_RELEASE_LIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-network-s.a)
	RASPBERRY_DEBUG_LIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-network-s-d.a)
	RASPBERRY_RELEASE_LIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-network-s.a)
	ANDROID_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-network-s-d.a)
	ANDROID_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-network-s.a)
endif()

if(sfml_sfml-system)
	WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-system-s-d.lib)
	WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-system-s.lib)
	MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-system-s-d.a)
	MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-system-s.a)
	IOS_DEBUG_LIB(${SFML}/${OS}/lib/Debug/libsfml-system-s-d.a)
	IOS_RELEASE_LIB(${SFML}/${OS}/lib/Release/libsfml-system-s.a)
	IOSSIM_DEBUG_LIB(${SFML}/${OS}/lib/Debug/libsfml-system-s-d.a)
	IOSSIM_RELEASE_LIB(${SFML}/${OS}/lib/Release/libsfml-system-s.a)
	LINUX_DEBUG_LIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-system-s-d.a)
	LINUX_RELEASE_LIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-system-s.a)
	RASPBERRY_DEBUG_LIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-system-s-d.a)
	RASPBERRY_RELEASE_LIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-system-s.a)
	ANDROID_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-system-s-d.a)
	ANDROID_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-system-s.a)
endif()

if(sfml_sfml-window)
	WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-window-s-d.lib)
	WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-window-s.lib)
	MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-window-s-d.a)
	MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-window-s.a)
	IOS_DEBUG_LIB(${SFML}/${OS}/lib/Debug/libsfml-window-s-d.a)
	IOS_RELEASE_LIB(${SFML}/${OS}/lib/Release/libsfml-window-s.a)
	IOSSIM_DEBUG_LIB(${SFML}/${OS}/lib/Debug/libsfml-window-s-d.a)
	IOSSIM_RELEASE_LIB(${SFML}/${OS}/lib/Release/libsfml-window-s.a)
	LINUX_DEBUG_LIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-window-s-d.a)
	LINUX_RELEASE_LIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-window-s.a)
	RASPBERRY_DEBUG_LIB(${SFML}/${OS}/${DEBUG_DIR}/lib/libsfml-window-s-d.a)
	RASPBERRY_RELEASE_LIB(${SFML}/${OS}/${RELEASE_DIR}/lib/libsfml-window-s.a)
	ANDROID_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-window-s-d.a)
	ANDROID_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-window-s.a)
endif()


### 3RDPARTY LINK ###
DKSET(SFML_WIN
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
WIN_PATH(${SFML}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} ${JPEG_WIN} ${OPENAL_WIN} ${OGG_WIN_CMAKE} ${VORBIS_WIN_RELEASE} ${FLAC_WIN} ${SFML})
WIN64_COMMAND(${DKCMAKE_WIN64} ${JPEG_WIN} ${OPENAL_WIN} ${OGG_WIN_CMAKE} ${VORBIS_WIN_RELEASE} ${FLAC_WIN}  ${SFML})
WIN_VS(SFML-${SFML_VERSION} SFML.sln)


MAC_PATH(${SFML}/${OS})
MAC32_COMMAND(${DKCMAKE_MAC32} ${JPEG_APPLE} ${OPENAL_APPLE} ${OGG_APPLE_CMAKE} ${VORBIS_APPLE_RELEASE} ${FLAC_APPLE} ${SFML})
MAC64_COMMAND(${DKCMAKE_MAC64} ${JPEG_APPLE} ${OPENAL_APPLE} ${OGG_APPLE_CMAKE} ${VORBIS_APPLE_RELEASE} ${FLAC_APPLE} ${SFML})
MAC_XCODE(SFML-${SFML_VERSION})


IOS_PATH(${SFML}/${OS})
IOS32_COMMAND(${DKCMAKE_IOS32} ${JPEG_APPLE} ${OPENAL_APPLE} ${OGG_APPLE_CMAKE} ${VORBIS_APPLE_RELEASE} ${FLAC_APPLE} ${SFML})
IOS64_COMMAND(${DKCMAKE_IOS64} ${JPEG_APPLE} ${OPENAL_APPLE} ${OGG_APPLE_CMAKE} ${VORBIS_APPLE_RELEASE} ${FLAC_APPLE} ${SFML})
IOS_XCODE(SFML-${SFML_VERSION})


IOSSIM_PATH(${SFML}/${OS})
IOSSIM32_COMMAND(${DKCMAKE_IOSSIM32} ${JPEG_APPLE} ${OPENAL_APPLE} ${OGG_APPLE_CMAKE} ${VORBIS_APPLE_RELEASE} ${FLAC_APPLE} ${SFML})
IOSSIM64_COMMAND(${DKCMAKE_IOSSIM64} ${JPEG_APPLE} ${OPENAL_APPLE} ${OGG_APPLE_CMAKE} ${VORBIS_APPLE_RELEASE} ${FLAC_APPLE} ${SFML})
IOSSIM_XCODE(SFML-${SFML_VERSION})


LINUX_DEBUG_PATH(${SFML}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${DKCMAKE_LINUX_DEBUG} ${JPEG_LINUX_DEBUG} ${OPENAL_LINUX_DEBUG} ${OGG_LINUX_CMAKE} ${VORBIS_LINUX_DEBUG} ${FLAC_LINUX_DEBUG} ${SFML})
LINUX_DEBUG_COMMAND(make)
LINUX_RELEASE_PATH(${SFML}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${DKCMAKE_LINUX_RELEASE} ${JPEG_LINUX_RELEASE} ${OPENAL_LINUX_RELEASE} ${OGG_LINUX_CMAKE} ${VORBIS_LINUX_RELEASE} ${FLAC_LINUX_RELEASE} ${SFML})
LINUX_RELEASE_COMMAND(make)


RASPBERRY_DEBUG_PATH(${SFML}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(${DKCMAKE_RASPBERRY_DEBUG} ${JPEG_RASPBERRY_DEBUG} ${OPENAL_RASPBERRY_DEBUG} ${OGG_RASPBERRY_CMAKE} ${VORBIS_RASPBERRY_DEBUG} ${FLAC_RASPBERRY_DEBUG} ${SFML})
RASPBERRY_DEBUG_COMMAND(make)
RASPBERRY_RELEASE_PATH(${SFML}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(${DKCMAKE_RASPBERRY_RELEASE} ${JPEG_RASPBERRY_RELEASE} ${OPENAL_RASPBERRY_RELEASE} ${OGG_RASPBERRY_CMAKE} ${VORBIS_RASPBERRY_RELEASE} ${FLAC_RASPBERRY_RELEASE} ${SFML})
RASPBERRY_RELEASE_COMMAND(make)


ANDROID_PATH(${SFML}/${OS})
ANDROID32_COMMAND(${DKCMAKE_ANDROID32} ${JPEG_ANDROID} ${OPENAL_ANDROID} ${OGG_ANDROID_CMAKE} ${VORBIS_ANDROID_DEBUG} ${FLAC_ANDROID} ${FREETYPE_ANDROID} ${OGG_ANDROID_CMAKE} ${SFML})
ANDROID64_COMMAND(${DKCMAKE_ANDROID64} ${JPEG_ANDROID} ${OPENAL_ANDROID} ${OGG_ANDROID_CMAKE} ${VORBIS_ANDROID_RELEASE} ${FLAC_ANDROID} ${FREETYPE_ANDROID} ${OGG_ANDROID_CMAKE} ${SFML})
ANDROID_VS(SFML-${SFML_VERSION} SFML.sln)
