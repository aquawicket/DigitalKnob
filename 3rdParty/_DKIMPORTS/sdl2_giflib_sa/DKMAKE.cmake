# https://github.com/theMealena/SDL2_giflib_sa.git
# https://github.com/theMealena/SDL2_giflib_sa/archive/master.zip


dk_depend(giflib)
dk_depend(DKSDLWindow)


dk_import(https://github.com/theMealena/SDL2_giflib_sa.git)


### LINK ###
dk_define				(USE_SDL2_gif)
dk_include				(${SDL2_GIFLIB_SA})
WIN_dk_libDebug			(${SDL2_GIFLIB_SA}/${OS}/${DEBUG_DIR}/SDL2_gif.lib)
WIN_dk_libRelease		(${SDL2_GIFLIB_SA}/${OS}/${RELEASE_DIR}/SDL2_gif.lib)
MAC_dk_libDebug			(${SDL2_GIFLIB_SA}/${OS}/${DEBUG_DIR}/libSDL2_gif.a)
MAC_dk_libRelease		(${SDL2_GIFLIB_SA}/${OS}/${RELEASE_DIR}/libSDL2_gif.a)
IOSSIM_dk_libDebug		(${SDL2_GIFLIB_SA}/${OS}/${DEBUG_DIR}-iphonesimulator/libSDL2_gif.a)
IOSSIM_dk_libRelease	(${SDL2_GIFLIB_SA}/${OS}/${RELEASE_DIR}-iphonesimulator/libSDL2_gif.a)
LINUX_dk_libDebug		(${SDL2_GIFLIB_SA}/${OS}/${DEBUG_DIR}/libSDL2_gif.a)
LINUX_dk_libRelease		(${SDL2_GIFLIB_SA}/${OS}/${RELEASE_DIR}/libSDL2_gif.a)
ANDROID_dk_libDebug		(${SDL2_GIFLIB_SA}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libSDL2_gif.a)
ANDROID_dk_libRelease	(${SDL2_GIFLIB_SA}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libSDL2_gif.a)


### GENERATE ###
dk_setPath		(${SDL2_GIFLIB_SA}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} ${SDL2_CMAKE} ${SDL2_GIFLIB_SA})


### COMPILE ###
WIN_dk_visualStudio			(${SDL2_GIFLIB_SA_NAME} SDL2_gif.sln SDL2_gif)
dk_xcode					(${SDL2_GIFLIB_SA_NAME} SDL2_gif)
LINUX_dk_queueCommand		(make)
RASPBERRY_dk_queueCommand	(make)
ANDROID_dk_ndk				(${SDL2_GIFLIB_SA_NAME})
