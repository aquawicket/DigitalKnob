### VERSION ###
DKSET(TIDY_MAJOR_VERSION 5)
DKSET(TIDY_MINOR_VERSION 7)
DKSET(TIDY_BUILD_VERSION 28)
DKSET(TIDY_VERSION ${TIDY_MAJOR_VERSION}.${TIDY_MINOR_VERSION}.${TIDY_BUILD_VERSION})
DKSET(TIDY_NAME tidy-html5-${TIDY_VERSION})
DKSET(TIDY ${3RDPARTY}/${TIDY_NAME})


### INSTALL ###
## https://github.com/htacg/tidy-html5/archive/5.7.28.zip
DKINSTALL(https://github.com/htacg/tidy-html5/archive/${TIDY_MAJOR_VERSION}.${TIDY_MINOR_VERSION}.${TIDY_BUILD_VERSION}.zip tidy-html5 ${TIDY_NAME})
DKRENAME(${DKDOWNLOAD}/${TIDY_MAJOR_VERSION}.${TIDY_MINOR_VERSION}.${TIDY_BUILD_VERSION}.zip ${DKDOWNLOAD}/${TIDY_NAME})



### LINK ###
DKINCLUDE(${TIDY})
DKINCLUDE(${TIDY}/include)
DKINCLUDE(${TIDY}/${OS})
ANDROID_INCLUDE(${TIDY}/${OS}/$(BUILD_TYPE)/jni)
WIN_DEBUG_LIB(${TIDY}/${OS}/${DEBUG_DIR}/tidysd.lib)
WIN_RELEASE_LIB(${TIDY}/${OS}/${RELEASE_DIR}/tidys.lib)
APPLE_DEBUG_LIB(${TIDY}/${OS}/${DEBUG_DIR}/libtidys.a)
APPLE_RELEASE_LIB(${TIDY}/${OS}/${RELEASE_DIR}/libtidys.a)
LINUX_DEBUG_LIB(${TIDY}/${OS}/${DEBUG_DIR}/libtidys.a)
LINUX_RELEASE_LIB(${TIDY}/${OS}/${RELEASE_DIR}/libtidys.a)
RASPBERRY_DEBUG_LIB(${TIDY}/${OS}/${DEBUG_DIR}/libtidys.a)
RASPBERRY_RELEASE_LIB(${TIDY}/${OS}/${RELEASE_DIR}/libtidys.a)
#ANDROID_DEBUG_LIB(${TIDY}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libtidys.a)
#ANDROID_RELEASE_LIB(${TIDY}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libtidys.a)
ANDROID_DEBUG_LIB(${TIDY}/${OS}/${DEBUG_DIR}/libtidys.a)
ANDROID_RELEASE_LIB(${TIDY}/${OS}/${RELEASE_DIR}/libtidys.a)


### COMPILE ###
WIN_PATH(${TIDY}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /I${ZLIB}/${OS}" ${TIDY})
WIN64_COMMAND(${DKCMAKE_WIN64} "-DCMAKE_C_FLAGS=/DWIN64 /D_WINDOWS /W3 /nologo /I${ZLIB}/${OS}" ${TIDY})
WIN_VS(${TIDY_NAME} tidy.sln tidy-static)


MAC_PATH(${TIDY}/${OS})
MAC64_COMMAND(${DKCMAKE_MAC64} ${TIDY})
MAC_XCODE(${TIDY_NAME} tidy)


IOS_PATH(${TIDY}/${OS})
IOS64_COMMAND(${DKCMAKE_IOS64} ${TIDY})
IOS_XCODE(${TIDY_NAME} tidy)


IOSSIM_PATH(${TIDY}/${OS})
IOSSIM64_COMMAND(${DKCMAKE_IOSSIM64} ${TIDY})
IOSSIM_XCODE(${TIDY_NAME} tidy)


LINUX_DEBUG_PATH(${TIDY}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG ${TIDY})
LINUX_DEBUG_COMMAND(make tidy)

LINUX_RELEASE_PATH(${TIDY}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE ${TIDY})
LINUX_RELEASE_COMMAND(make tidy)


RASPBERRY_DEBUG_PATH(${TIDY}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG ${TIDY})
RASPBERRY_DEBUG_COMMAND(make tidy)

RASPBERRY_RELEASE_PATH(${TIDY}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE ${TIDY})
RASPBERRY_RELEASE_COMMAND(make tidy)


#ANDROID_NDK(${TIDY_NAME})

ANDROID_PATH(${TIDY}/${OS})
ANDROID32_COMMAND(${DKCMAKE_WIN32} "-DANDROID_COMPILER_FLAGS=-DANDROID32 -D_ANDROID -I${ZLIB}/${OS}" ${TIDY})
ANDROID64_COMMAND(${DKCMAKE_WIN64} "-DANDROID_COMPILER_FLAGS=-DANDROID64 -D_ANDROID -I${ZLIB}/${OS}" ${TIDY})
ANDROID_VS(${TIDY_NAME} tidy.sln tidy-static)