IF(LINUX)
	DKDEPEND(openal)
	DKDEPEND(flac)
ENDIF()


### VERSION ### 
DKSET(SFML_VERSION 2.4.2)

DKSET(SFML ${3RDPARTY}/SFML-${SFML_VERSION})
DKSET(SFML_INCLUDE_DIR ${SFML}/include)
DKSET(SFML_MAIN_LIBRARY_DEBUG ${SFML}/${OS}/lib/Debug/sfml-main-d.lib)
DKSET(SFML_MAIN_LIBRARY_RELEASE ${SFML}/${OS}/lib/Release/sfml-main.lib)
DKSET(SFML_SYSTEM_LIBRARY_DEBUG ${SFML}/${OS}/lib/Debug/sfml-system-s-d.lib)
DKSET(SFML_SYSTEM_LIBRARY_RELEASE ${SFML}/${OS}/lib/Debug/sfml-system-s.lib)
DKSET(SFML_WINDOW_LIBRARY_DEBUG ${SFML}/${OS}/lib/Debug/sfml-window-s-d.lib)
DKSET(SFML_WINDOW_LIBRARY_RELEASE ${SFML}/${OS}/lib/Release/sfml-window-s.lib)
DKSET(SFML_GRAPHICS_LIBRARY_DEBUG ${SFML}/${OS}/lib/Debug/sfml-graphics-s-d.lib)
DKSET(SFML_GRAPHICS_LIBRARY_RELEASE ${SFML}/${OS}/lib/Release/sfml-graphics-s.lib)


### INSTALL ###
DKINSTALL(https://www.sfml-dev.org/files/SFML-${SFML_VERSION}-sources.zip SFML SFML-${SFML_VERSION})


### LINK ###
DKDEFINE(SFML_STATIC)
DKINCLUDE(${SFML}/include)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/Debug/sfml-audio-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/Release/sfml-audio-s.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/Debug/sfml-graphics-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/Release/sfml-graphics-s.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/Debug/sfml-main-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/Release/sfml-main.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/Debug/sfml-network-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/Release/sfml-network-s.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/Debug/sfml-system-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/Release/sfml-system-s.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/Debug/sfml-window-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/Release/sfml-window-s.lib)
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
IOSSIM_RELEASE_LIB(${SFML}/Xcode-iOS/SFML/build/Release-iphonesimulator/libSFML.a)
LINUX_DEBUG_LIB(${SFML}/${OS}/Debug/libSFML.a)
LINUX_RELEASE_LIB(${SFML}/${OS}/Release/libSFML.a)
ANDROID_DEBUG_LIB(${SFML}/${OS}/Debug/obj/local/armeabi-v7a/libSFML.so)
ANDROID_RELEASE_LIB(${SFML}/${OS}/Release/obj/local/armeabi-v7a/libSFML.so)
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

DKSETPATH(${SFML}/${OS}/Debug)
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_C_FLAGS=-fPIC -DJPEG_LIBRARY=${JPEG}/${OS}/Debug/libjpeg-static.a -DJPEG_INCLUDE_DIR=${JPEG} -DOPENAL_LIBRARY=${OPENAL}/${OS}/Debug/libopenal.a -DOPENAL_INCLUDE_DIR=${OPENAL}/include ${SFML})
LINUX_DEBUG_COMMAND(make)

DKSETPATH(${SFML}/${OS}/Release)
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_C_FLAGS=-fPIC -DJPEG_LIBRARY=${JPEG}/${OS}/Release/libjpeg-static.a -DJPEG_INCLUDE_DIR=${JPEG} -DOPENAL_LIBRARY=${OPENAL}/${OS}/Release/libopenal.a -DOPENAL_INCLUDE_DIR=${OPENAL}/include -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/Release/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/Release/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/Release/lib/.libs/libvorbisenc.a -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/Release/src/.libs/libogg.a ${SFML})
LINUX_RELEASE_COMMAND(make)




### INJECT ###
DKSET(SFML_WIN32 
	-DSFML_INCLUDE_DIR=${SFML}/include
	-DSFML_MAIN_LIBRARY_DEBUG=${SFML}/${OS}/lib/Debug/sfml-main-d.lib
	-DSFML_MAIN_LIBRARY_RELEASE=${SFML}/${OS}/lib/Release/sfml-main.lib
	-DSFML_SYSTEM_LIBRARY_DEBUG=${SFML}/${OS}/lib/Debug/sfml-system-s-d.lib
	-DSFML_SYSTEM_LIBRARY_RELEASE=${SFML}/${OS}/lib/Debug/sfml-system-s.lib
	-DSFML_WINDOW_LIBRARY_DEBUG=${SFML}/${OS}/lib/Debug/sfml-window-s-d.lib
	-DSFML_WINDOW_LIBRARY_RELEASE=${SFML}/${OS}/lib/Release/sfml-window-s.lib
	-DSFML_GRAPHICS_LIBRARY_DEBUG=${SFML}/${OS}/lib/Debug/sfml-graphics-s-d.lib
	-DSFML_GRAPHICS_LIBRARY_RELEASE=${SFML}/${OS}/lib/Release/sfml-graphics-s.lib
	-DSFML_AUDIO_LIBRARY_DEBUG=${SFML}/${OS}/lib/Debug/sfml-audio-s-d.lib
	-DSFML_AUDIO_LIBRARY_RELEASE=${SFML}/${OS}/lib/Release/sfml-audio-s.lib)