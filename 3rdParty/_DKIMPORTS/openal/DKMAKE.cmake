### VERSION ###
DKSET(OPENAL_VERSION 1.15.1)
DKSET(OPENAL ${3RDPARTY}/openal-${OPENAL_VERSION})


### INSTALL ###
## https://www.openal-soft.org/openal-releases/openal-soft-1.15.1.tar.bz2
DKINSTALL(https://www.openal-soft.org/openal-releases/openal-soft-${OPENAL_VERSION}.tar.bz2 openal openal-${OPENAL_VERSION})


### LINK ###
IF(WIN)
	DKDEFINE(__WINDOWS_MM__)
	LIST(APPEND WIN_LIBS winmm.lib)
ENDIF()
DKINCLUDE(${OPENAL}/include)
DKINCLUDE(${OPENAL}/include/AL)
DKDEFINE(AL_LIBTYPE_STATIC)
FILE(REMOVE ${OPENAL}/include/AL/stdint.h)
FILE(REMOVE ${OPENAL}/include/AL/inttypes.h)
WIN_DEBUG_LIB(${OPENAL}/${OS}/${DEBUG_DIR}/OpenAL32.lib)
WIN_RELEASE_LIB(${OPENAL}/${OS}/${RELEASE_DIR}/OpenAL32.lib)
APPLE_DEBUG_LIB(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
APPLE_RELEASE_LIB(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)
LINUX_DEBUG_LIB(${OPENAL}/${OS}/${DEBUG_DIR}/libopenal.a)
LINUX_RELEASE_LIB(${OPENAL}/${OS}/${RELEASE_DIR}/libopenal.a)


### COMPILE ###
WIN_PATH(${OPENAL}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /DAL_LIBTYPE_STATIC" -DLIBTYPE=STATIC -DEXAMPLES=OFF -DFORCE_STATIC_VCRT=ON ${OPENAL})
WIN64_COMMAND(${DKCMAKE_WIN32} "-DCMAKE_C_FLAGS=/DWIN64 /D_WINDOWS /W3 /nologo /DAL_LIBTYPE_STATIC" -DLIBTYPE=STATIC -DEXAMPLES=OFF -DFORCE_STATIC_VCRT=ON ${OPENAL})
WIN_VS(openal OpenAL.sln OpenAL32)

MAC_PATH(${OPENAL}/${OS})
MAC64_COMMAND(${DKCMAKE_MAC64} -DLIBTYPE=STATIC -DEXAMPLES=OFF -DFORCE_STATIC_VCRT=ON ${OPENAL})
MAC_XCODE(openal openal)

LINUX_DEBUG_PATH(${OPENAL}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_C_FLAGS=-fPIC -DLIBTYPE=STATIC -DEXAMPLES=OFF -DFORCE_STATIC_VCRT=ON ${OPENAL})
LINUX_DEBUG_COMMAND(make)

LINUX_RELEASE_PATH(${OPENAL}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_C_FLAGS=-fPIC -DLIBTYPE=STATIC -DEXAMPLES=OFF -DFORCE_STATIC_VCRT=ON ${OPENAL})
LINUX_RELEASE_COMMAND(make)

RASPBERRY_DEBUG_PATH(${OPENAL}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_C_FLAGS=-fPIC -DLIBTYPE=STATIC -DEXAMPLES=OFF -DFORCE_STATIC_VCRT=ON ${OPENAL})
RASPBERRY_DEBUG_COMMAND(make)

RASPBERRY_RELEASE_PATH(${OPENAL}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_C_FLAGS=-fPIC -DLIBTYPE=STATIC -DEXAMPLES=OFF -DFORCE_STATIC_VCRT=ON ${OPENAL})
RASPBERRY_RELEASE_COMMAND(make)


ANDROID_PATH(${OPENAL}/${OS})
ANDROID32_COMMAND(${DKCMAKE_ANDROID32} -DLIBTYPE=STATIC -DEXAMPLES=OFF -DFORCE_STATIC_VCRT=ON ${OPENAL})
ANDROID64_COMMAND(${DKCMAKE_ANDROID64} -DLIBTYPE=STATIC -DEXAMPLES=OFF -DFORCE_STATIC_VCRT=ON ${OPENAL})
ANDROID_VS(libjpeg-turbo-${JPEG_VERSION} libjpeg-turbo.sln turbojpeg-static)