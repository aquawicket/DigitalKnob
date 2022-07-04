# sdl2_gif

dk_depend(DKSDLWindow)

dk_set			(SDL2_GIF_NAME SDL2_gif)
dk_set			(SDL2_GIF ${3RDPARTY}/${SDL2_GIF_NAME})
IF(NOT EXISTS ${SDL2_GIF})
	dk_extract	(${DKIMPORTS}/sdl2_gif/gif_2_lib.zip ${3RDPARTY})
	dk_rename	(${3RDPARTY}/SDL2 ${SDL2_GIF} OVERWRITE)
	dk_copy		(${DKIMPORTS}/sdl2_gif ${SDL2_GIF} OVERWRITE)
ENDIF()


### LINK ###
dk_define				(USE_SDL2_gif)
dk_include				(${SDL2_GIF})
WIN_dk_libDebug			(${SDL2_GIF}/${OS}/${DEBUG_DIR}/SDL2_gif.lib)
WIN_dk_libRelease		(${SDL2_GIF}/${OS}/${RELEASE_DIR}/SDL2_gif.lib)
MAC_dk_libDebug			(${SDL2_GIF}/${OS}/${DEBUG_DIR}/libSDL2_gif.a)
MAC_dk_libRelease		(${SDL2_GIF}/${OS}/${RELEASE_DIR}/libSDL2_gif.a)
IOSSIM_dk_libDebug		(${SDL2_GIF}/${OS}/Debug-iphonesimulator/libSDL2_gif.a)
IOSSIM_dk_libRelease	(${SDL2_GIF}/${OS}/Release-iphonesimulator/libSDL2_gif.a)
LINUX_dk_libDebug		(${SDL2_GIF}/${OS}/${DEBUG_DIR}/libSDL2_gif.a)
LINUX_dk_libRelease		(${SDL2_GIF}/${OS}/${RELEASE_DIR}/libSDL2_gif.a)
RASPBERRY_dk_libDebug	(${SDL2_GIF}/${OS}/${DEBUG_DIR}/libSDL2_gif.a)
RASPBERRY_dk_libRelease	(${SDL2_GIF}/${OS}/${RELEASE_DIR}/libSDL2_gif.a)
#ANDROID_dk_libDebug	(${SDL2_GIF}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libSDL2_gif.a)
#ANDROID_dk_libRelease	(${SDL2_GIF}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libSDL2_gif.a)
ANDROID_dk_libDebug		(${SDL2_GIF}/${OS}/${DEBUG_DIR}/libSDL2_gif.a)
ANDROID_dk_libRelease	(${SDL2_GIF}/${OS}/${RELEASE_DIR}/libSDL2_gif.a)


### GENERATE ###
dk_setPath		(${SDL2_GIF}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} ${SDL2_CMAKE} ${SDL2_GIF})


### COMPILE ###
dk_visualStudio				(${SDL2_GIF_NAME} SDL2_gif)
dk_xcode					(${SDL2_GIF_NAME} SDL2_gif)
LINUX_dk_queueCommand		(make)
RASPBERRY_dk_queueCommand	(make)
