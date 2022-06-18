dk_depend(DKSDLWindow)


dk_set(SDLGIF_NAME SDL2_gif)
dk_set(SDLGIF ${3RDPARTY}/${SDLGIF_NAME})
IF(NOT EXISTS ${SDLGIF})
	dk_extract(${DKIMPORTS}/sdl2_gif/gif_2_lib.zip ${3RDPARTY})
	dk_rename(${3RDPARTY}/SDL2 ${SDLGIF})
	dk_copy(${DKIMPORTS}/sdl2_gif ${SDLGIF} TRUE)
ENDIF()



### LINK ###
dk_define(USE_SDL2_gif)
dk_include(${SDLGIF})
WIN_DEBUG_DKLIB(${SDLGIF}/${OS}/${DEBUG_DIR}/SDL2_gif.lib)
WIN_RELEASE_DKLIB(${SDLGIF}/${OS}/${RELEASE_DIR}/SDL2_gif.lib)
MAC_DEBUG_DKLIB(${SDLGIF}/${OS}/${DEBUG_DIR}/libSDL2_gif.a)
MAC_RELEASE_DKLIB(${SDLGIF}/${OS}/${RELEASE_DIR}/libSDL2_gif.a)
IOSSIM_DEBUG_DKLIB(${SDLGIF}/${OS}/Debug-iphonesimulator/libSDL2_gif.a)
IOSSIM_RELEASE_DKLIB(${SDLGIF}/${OS}/Release-iphonesimulator/libSDL2_gif.a)
LINUX_DEBUG_DKLIB(${SDLGIF}/${OS}/${DEBUG_DIR}/libSDL2_gif.a)
LINUX_RELEASE_DKLIB(${SDLGIF}/${OS}/${RELEASE_DIR}/libSDL2_gif.a)
RASPBERRY_DEBUG_DKLIB(${SDLGIF}/${OS}/${DEBUG_DIR}/libSDL2_gif.a)
RASPBERRY_RELEASE_DKLIB(${SDLGIF}/${OS}/${RELEASE_DIR}/libSDL2_gif.a)
##ANDROID_DEBUG_DKLIB(${SDLGIF}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libSDL2_gif.a)
##ANDROID_RELEASE_DKLIB(${SDLGIF}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libSDL2_gif.a)
ANDROID_DEBUG_DKLIB(${SDLGIF}/${OS}/${DEBUG_DIR}/libSDL2_gif.a)
ANDROID_RELEASE_DKLIB(${SDLGIF}/${OS}/${RELEASE_DIR}/libSDL2_gif.a)



### COMPILE ###
dk_setPath(${SDLGIF}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${SDL2_CMAKE} ${SDLGIF})


WIN_VS(${SDLGIF_NAME} SDL2_gif.sln SDL2_gif)
MAC_XCODE(${SDLGIF_NAME} SDL2_gif)
IOSSIM_XCODE(${SDLGIF_NAME} SDL2_gif)
LINUX_dk_queueCommand(make)
RASPBERRY_dk_queueCommand(make)
ANDROID_VS(${SDLGIF_NAME} SDL2_gif.sln SDL2_gif)
