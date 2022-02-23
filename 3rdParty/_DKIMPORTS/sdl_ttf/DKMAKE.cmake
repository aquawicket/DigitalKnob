# https://github.com/libsdl-org/SDL_ttf
# https://www.libsdl.org/projects/SDL_ttf
# https://github.com/aquawicket/SDL_ttf
#
# https://github.com/aquawicket/SDL_ttf/archive/refs/heads/main.zip
# https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.15.zip

### DEPENDS ###
DKDEPEND(sdl)
DKDEPEND(freetype)


#DKIMPORT(https://github.com/libsdl-org/SDL_ttf)
DKIMPORT(https://github.com/libsdl-org/SDL_ttf/archive/9a8650d82824bd8d971dd77d74b67315c4150b07.zip PATCH)
#DKSET(SDL_TTF_VERSION main)
#DKSET(SDL_TTF_NAME SDL2_ttf-${SDL_TTF_VERSION})
#DKSET(SDL_TTF_DL https://github.com/aquawicket/SDL_ttf/archive/refs/heads/${SDL_TTF_VERSION}.zip)
#DKSET(SDL_TTF ${3RDPARTY}/${SDL_TTF_NAME})
#DKINSTALL(${SDL_TTF_DL} sdl_ttf ${SDL_TTF})



### LINK ###
DKINCLUDE(${SDL_TTF})
WIN_DEBUG_DKLIB(${SDL_TTF}/${OS}/lib/${DEBUG_DIR}/SDL_ttf.lib)
WIN_RELEASE_DKLIB(${SDL_TTF}/${OS}/lib/${RELEASE_DIR}/SDL_ttf.lib)
APPLE_DEBUG_DKLIB(${SDL_TTF}/${OS}/lib/Debug/SDL_ttf.a)
APPLE_RELEASE_DKLIB(${SDL_TTF}/${OS}/lib/Release/SDL_ttf.a)
LINUX_DEBUG_DKLIB(${SDL_TTF}/${OS}/${DEBUG_DIR}/lib/SDL_ttf.a)
LINUX_RELEASE_DKLIB(${SDL_TTF}/${OS}/${RELEASE_DIR}/lib/SDL_ttf.a)
RASPBERRY_DEBUG_DKLIB(${SDL_TTF}/${OS}/${DEBUG_DIR}/lib/SDL_ttf.a)
RASPBERRY_RELEASE_DKLIB(${SDL_TTF}/${OS}/${RELEASE_DIR}/lib/SDL_ttf.a)
ANDROID_DEBUG_DKLIB(${SDL_TTF}/${OS}/lib/${DEBUG_DIR}/SDL_ttf.a)
ANDROID_RELEASE_DKLIB(${SDL_TTF}/${OS}/lib/${RELEASE_DIR}/SDL_ttf.a)




### COMPILE ###
DKSETPATH(${SDL_TTF}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_SHARED_LIBS=OFF -DSDLTTF_SUPPORT_WEBP=OFF ${SDL_CMAKE} ${FREETYPE_CMAKE} ${SDL_TTF})



WIN_VS(${SDL_TTF_NAME} SDLTTF.sln SDLTTF)
MAC_XCODE(${SDL_TTF_NAME} SDLTTF)
IOS_XCODE(${SDL_TTF_NAME} SDLTTF)
IOSSIM_XCODE(${SDL_TTF_NAME} SDLTTF)
LINUX_DKQCOMMAND(make SDLTTF)
RASPBERRY_DKQCOMMAND(make SDLTTF)
ANDROID_VS(${SDL_TTF_NAME} SDLTTF.sln SDLTTF)
