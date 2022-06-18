# https://github.com/theMealena/SDL2_giflib_sa/archive/master.zip

### DEPENDS ###
dk_depend(giflib)
dk_depend(DKSDLWindow)


dk_import(https://github.com/theMealena/SDL2_giflib_sa.git)

#dk_set(SDLGIF_VERSION master)
#dk_set(SDLGIF_NAME SDL2_giflib_sa-${SDLGIF_VERSION})
#dk_set(SDLGIF_DL https://github.com/theMealena/SDL2_giflib_sa/archive/${SDLGIF_VERSION}.zip)
#dk_set(SDLGIF ${3RDPARTY}/${SDLGIF_NAME})
#dk_install(${SDLGIF_DL} SDL2_giflib_sa ${SDLGIF})





### LINK ###
dk_define(USE_SDL2_gif)
dk_include(${SDLGIF})
WIN_DEBUG_DKLIB(${SDLGIF}/${OS}/${DEBUG_DIR}/SDL2_gif.lib)
WIN_RELEASE_DKLIB(${SDLGIF}/${OS}/${RELEASE_DIR}/SDL2_gif.lib)
MAC_DEBUG_DKLIB(${SDLGIF}/${OS}/${DEBUG_DIR}/libSDL2_gif.a)
MAC_RELEASE_DKLIB(${SDLGIF}/${OS}/${RELEASE_DIR}/libSDL2_gif.a)
IOSSIM_DEBUG_DKLIB(${SDLGIF}/${OS}/${DEBUG_DIR}-iphonesimulator/libSDL2_gif.a)
IOSSIM_RELEASE_DKLIB(${SDLGIF}/${OS}/${RELEASE_DIR}-iphonesimulator/libSDL2_gif.a)
LINUX_DEBUG_DKLIB(${SDLGIF}/${OS}/${DEBUG_DIR}/libSDL2_gif.a)
LINUX_RELEASE_DKLIB(${SDLGIF}/${OS}/${RELEASE_DIR}/libSDL2_gif.a)
ANDROID_DEBUG_DKLIB(${SDLGIF}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libSDL2_gif.a)
ANDROID_RELEASE_DKLIB(${SDLGIF}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libSDL2_gif.a)


### COMPILE ###
dk_setPath(${SDLGIF}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} ${SDL2_CMAKE} ${SDLGIF})


WIN_VS(${SDLGIF_NAME} SDL2_gif.sln SDL2_gif)
MAC_XCODE(${SDLGIF_NAME} SDL2_gif)
IOS_XCODE(${SDLGIF_NAME} SDL2_gif)
IOSSIM_XCODE(${SDLGIF_NAME} SDL2_gif)
LINUX_DKQCOMMAND(make)
ANDROID_NDK(${SDLGIF_NAME})
