IF(LINUX)
	DKDEPEND(openal)
	DKDEPEND(flac)
ENDIF()


### VERSION ### 
DKSET(SFML_VERSION 2.4.2)

DKSET(SFML ${3RDPARTY}/SFML-${SFML_VERSION})
DKSET(SFML_INCLUDE_DIR ${SFML}/include)
DKSET(SFML_MAIN_LIBRARY_DEBUG ${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-main-d.lib)
DKSET(SFML_MAIN_LIBRARY_RELEASE ${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-main.lib)
DKSET(SFML_SYSTEM_LIBRARY_DEBUG ${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-system-s-d.lib)
DKSET(SFML_SYSTEM_LIBRARY_RELEASE ${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-system-s.lib)
DKSET(SFML_WINDOW_LIBRARY_DEBUG ${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-window-s-d.lib)
DKSET(SFML_WINDOW_LIBRARY_RELEASE ${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-window-s.lib)
DKSET(SFML_GRAPHICS_LIBRARY_DEBUG ${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-graphics-s-d.lib)
DKSET(SFML_GRAPHICS_LIBRARY_RELEASE ${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-graphics-s.lib)


### INSTALL ###
DKINSTALL(https://www.sfml-dev.org/files/SFML-${SFML_VERSION}-sources.zip SFML SFML-${SFML_VERSION})


### LINK ###
DKDEFINE(SFML_STATIC)
DKINCLUDE(${SFML}/include)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-audio-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-audio-s.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-graphics-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-graphics-s.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-main-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-main.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-network-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-network-s.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-system-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-system-s.lib)
WIN_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-window-s-d.lib)
WIN_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-window-s.lib)
MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-audio-s-d.a)
MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-audio-s.a)
MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-graphics-s-d.a)
MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-graphics-s.a)
MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-network-s-d.a)
MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-network-s.a)
MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-system-s-d.a)
MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-system-s.a)
MAC_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-window-s-d.a)
MAC_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-window-s.a)
IOSSIM_DEBUG_LIB(${SFML}/Xcode-iOS/SFML/build/Debug-iphonesimulator/libSFML.a)
IOSSIM_RELEASE_LIB(${SFML}/Xcode-iOS/SFML/build/${RELEASE_DIR}-iphonesimulator/libSFML.a)
LINUX_DEBUG_LIB(${SFML}/${OS}/${DEBUG_DIR}/libSFML.a)
LINUX_RELEASE_LIB(${SFML}/${OS}/${RELEASE_DIR}/libSFML.a)
##ANDROID_DEBUG_LIB(${SFML}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libSFML.so)
##ANDROID_RELEASE_LIB(${SFML}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libSFML.so)
ANDROID_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-audio-s-d.a)
ANDROID_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-audio-s.a)
ANDROID_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-graphics-s-d.a)
ANDROID_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-graphics-s.a)
ANDROID_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-network-s-d.a)
ANDROID_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-network-s.a)
ANDROID_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-system-s-d.a)
ANDROID_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-system-s.a)
ANDROID_DEBUG_LIB(${SFML}/${OS}/lib/${DEBUG_DIR}/libsfml-window-s-d.a)
ANDROID_RELEASE_LIB(${SFML}/${OS}/lib/${RELEASE_DIR}/libsfml-window-s.a)
LIST(APPEND WIN_LIBS winmm.lib)

### 3RDPARTY LINL ###
DKSET(SFML_WIN32 
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
WIN32_COMMAND(${DKCMAKE_WIN32} "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /D__FLTUSED__" ${SFML})
WIN64_COMMAND(${DKCMAKE_WIN64} "-DCMAKE_C_FLAGS=/DWIN64 /D_WINDOWS /W3 /nologo /D__FLTUSED__" ${SFML})
WIN_VS(SFML-${SFML_VERSION} SFML.sln)


DKSETPATH(${SFML}/${OS})
MAC_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_OSX_ARCHITECTURES=x86_64 ${SFML})
MAC_XCODE_DEBUG(SFML-${SFML_VERSION})
MAC_XCODE_RELEASE(SFML-${SFML_VERSION})


DKSETPATH(${SFML}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_C_FLAGS=-fPIC -DJPEG_LIBRARY=${JPEG}/${OS}/${DEBUG_DIR}/libjpeg-static.a -DJPEG_INCLUDE_DIR=${JPEG} -DOPENAL_LIBRARY=${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a -DOPENAL_INCLUDE_DIR=${OPENAL}/include ${SFML})
LINUX_DEBUG_COMMAND(make)


DKSETPATH(${SFML}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_C_FLAGS=-fPIC -DJPEG_LIBRARY=${JPEG}/${OS}/${RELEASE_DIR}/libjpeg-static.a -DJPEG_INCLUDE_DIR=${JPEG} -DOPENAL_LIBRARY=${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a -DOPENAL_INCLUDE_DIR=${OPENAL}/include -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a ${SFML})
LINUX_RELEASE_COMMAND(make)


ANDROID_PATH(${SFML}/${OS})
ANDROID32_COMMAND(${DKCMAKE_ANDROID32} ${SFML})
ANDROID64_COMMAND(${DKCMAKE_ANDROID64} ${SFML})
ANDROID_VS(SFML-${SFML_VERSION} SFML.sln)
