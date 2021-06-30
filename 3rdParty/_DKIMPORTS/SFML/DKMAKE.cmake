IF(LINUX)
	DKDEPEND(openal)
	DKDEPEND(flac)
ENDIF()


### VERSION ### 
DKSET(SFML_VERSION 2.4.2)

DKSET(SFML ${3RDPARTY}/SFML-${SFML_VERSION})
DKSET(SFML_INCLUDE_DIR ${SFML}/include)
DKSET(SFML_MAIN_LIBRARY_DEBUG ${SFML}/${OS}/lib/${DEBUG}/sfml-main-d.lib)
DKSET(SFML_MAIN_LIBRARY_RELEASE ${SFML}/${OS}/lib/${RELEASE}/sfml-main.lib)
DKSET(SFML_SYSTEM_LIBRARY_DEBUG ${SFML}/${OS}/lib/${DEBUG}/sfml-system-s-d.lib)
DKSET(SFML_SYSTEM_LIBRARY_RELEASE ${SFML}/${OS}/lib/${RELEASE}/sfml-system-s.lib)
DKSET(SFML_WINDOW_LIBRARY_DEBUG ${SFML}/${OS}/lib/${DEBUG}/sfml-window-s-d.lib)
DKSET(SFML_WINDOW_LIBRARY_RELEASE ${SFML}/${OS}/lib/${RELEASE}/sfml-window-s.lib)
DKSET(SFML_GRAPHICS_LIBRARY_DEBUG ${SFML}/${OS}/lib/${DEBUG}/sfml-graphics-s-d.lib)
DKSET(SFML_GRAPHICS_LIBRARY_RELEASE ${SFML}/${OS}/lib/${RELEASE}/sfml-graphics-s.lib)


### INSTALL ###
DKINSTALL(https://www.sfml-dev.org/files/SFML-${SFML_VERSION}-sources.zip SFML SFML-${SFML_VERSION})


### LINK ###
DKDEFINE(SFML_STATIC)
DKINCLUDE(${SFML}/include)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG}/sfml-audio-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE}/sfml-audio-s.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG}/sfml-graphics-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE}/sfml-graphics-s.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG}/sfml-main-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE}/sfml-main.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG}/sfml-network-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE}/sfml-network-s.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG}/sfml-system-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE}/sfml-system-s.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG}/sfml-window-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE}/sfml-window-s.lib)
MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG}/libsfml-audio-s-d.a)
MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE}/libsfml-audio-s.a)
MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG}/libsfml-graphics-s-d.a)
MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE}/libsfml-graphics-s.a)
MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG}/libsfml-network-s-d.a)
MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE}/libsfml-network-s.a)
MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG}/libsfml-system-s-d.a)
MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE}/libsfml-system-s.a)
MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG}/libsfml-window-s-d.a)
MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE}/libsfml-window-s.a)
IOSSIM_DEBUG_LIB(${SFML}/Xcode-iOS/SFML/build/Debug-iphonesimulator/libSFML.a)
IOSSIM_RELEASE_LIB(${SFML}/Xcode-iOS/SFML/build/${RELEASE}-iphonesimulator/libSFML.a)
LINUX_DEBUG_LIB(${SFML}/${OS}/${DEBUG}/libSFML.a)
LINUX_RELEASE_LIB(${SFML}/${OS}/${RELEASE}/libSFML.a)
ANDROID_DEBUG_LIB(${SFML}/${OS}/${DEBUG}/obj/local/armeabi-v7a/libSFML.so)
ANDROID_RELEASE_LIB(${SFML}/${OS}/${RELEASE}/obj/local/armeabi-v7a/libSFML.so)
LIST(APPEND WIN_LIBS winmm.lib)


### COMPILE ###
DKSETPATH(${SFML}/${OS})
WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A Win32 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /D__FLTUSED__" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" ${SFML})
WIN32_VS_DEBUG(SFML-${SFML_VERSION} SFML.sln)
WIN32_VS_RELEASE(SFML-${SFML_VERSION} SFML.sln)

DKSETPATH(${SFML}/${OS})
WIN64_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A x64 "-DCMAKE_C_FLAGS=/DWIN64 /D_WINDOWS /W3 /nologo /D__FLTUSED__" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" ${SFML})
WIN64_VS_DEBUG(SFML-${SFML_VERSION} SFML.sln)
WIN64_VS_RELEASE(SFML-${SFML_VERSION} SFML.sln)

DKSETPATH(${SFML}/${OS})
MAC_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_OSX_ARCHITECTURES=x86_64 ${SFML})
MAC_XCODE_DEBUG(SFML-${SFML_VERSION})
MAC_XCODE_RELEASE(SFML-${SFML_VERSION})

DKSETPATH(${SFML}/${OS}/${DEBUG})
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_C_FLAGS=-fPIC -DJPEG_LIBRARY=${JPEG}/${OS}/${DEBUG}/libjpeg-static.a -DJPEG_INCLUDE_DIR=${JPEG} -DOPENAL_LIBRARY=${OPENAL}/${OS}/${DEBUG}/libopenal.a -DOPENAL_INCLUDE_DIR=${OPENAL}/include ${SFML})
LINUX_DEBUG_COMMAND(make)

DKSETPATH(${SFML}/${OS}/${RELEASE})
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_C_FLAGS=-fPIC -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE}/libjpeg-static.a -DJPEG_INCLUDE_DIR=${JPEG} -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE}/libopenal.a -DOPENAL_INCLUDE_DIR=${OPENAL}/include -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbisenc.a -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE}/src/.libs/libogg.a ${SFML})
LINUX_RELEASE_COMMAND(make)




### INJECT ###
DKSET(SFML_WIN32 
	-DSFML_INCLUDE_DIR=${SFML}/include
	-DSFML_MAIN_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG}/sfml-main-d.lib
	-DSFML_MAIN_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE}/sfml-main.lib
	-DSFML_SYSTEM_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG}/sfml-system-s-d.lib
	-DSFML_SYSTEM_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE}/sfml-system-s.lib
	-DSFML_WINDOW_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG}/sfml-window-s-d.lib
	-DSFML_WINDOW_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE}/sfml-window-s.lib
	-DSFML_GRAPHICS_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG}/sfml-graphics-s-d.lib
	-DSFML_GRAPHICS_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE}/sfml-graphics-s.lib
	-DSFML_AUDIO_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG}/sfml-audio-s-d.lib
	-DSFML_AUDIO_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE}/sfml-audio-s.lib)