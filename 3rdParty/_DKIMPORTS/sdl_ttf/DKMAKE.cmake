# https://github.com/libsdl-org/SDL_ttf
# https://www.libsdl.org/projects/SDL_ttf
# https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.15.zip

### DEPENDS ###
dk_depend(sdl)
dk_depend(freetype)


dk_import(https://github.com/libsdl-org/SDL_ttf.git main PATCH)
#dk_import(https://github.com/libsdl-org/SDL_ttf/archive/970e703dd144ffefdcd7cb5f47b20f56d903172c.zip PATCH)
#dk_import(https://github.com/libsdl-org/SDL_ttf/archive/9a8650d82824bd8d971dd77d74b67315c4150b07.zip PATCH)
#dk_set(SDL_TTF_VERSION main)
#dk_set(SDL_TTF_NAME SDL2_ttf-${SDL_TTF_VERSION})
#dk_set(SDL_TTF ${3RDPARTY}/${SDL_TTF_NAME})
#dk_install(${SDL_TTF_DL} sdl_ttf ${SDL_TTF} PATCH)



### LINK ###
dk_include(${SDL_TTF})
WIN_dk_libDebug(${SDL_TTF}/${OS}/lib/${DEBUG_DIR}/SDL_ttf.lib)
WIN_dk_libRelease(${SDL_TTF}/${OS}/lib/${RELEASE_DIR}/SDL_ttf.lib)
APPLE_dk_libDebug(${SDL_TTF}/${OS}/lib/Debug/SDL_ttf.a)
APPLE_dk_libRelease(${SDL_TTF}/${OS}/lib/Release/SDL_ttf.a)
LINUX_dk_libDebug(${SDL_TTF}/${OS}/${DEBUG_DIR}/lib/SDL_ttf.a)
LINUX_dk_libRelease(${SDL_TTF}/${OS}/${RELEASE_DIR}/lib/SDL_ttf.a)
RASPBERRY_dk_libDebug(${SDL_TTF}/${OS}/${DEBUG_DIR}/lib/SDL_ttf.a)
RASPBERRY_dk_libRelease(${SDL_TTF}/${OS}/${RELEASE_DIR}/lib/SDL_ttf.a)
ANDROID_dk_libDebug(${SDL_TTF}/${OS}/lib/${DEBUG_DIR}/SDL_ttf.a)
ANDROID_dk_libRelease(${SDL_TTF}/${OS}/lib/${RELEASE_DIR}/SDL_ttf.a)




### COMPILE ###
dk_setPath(${SDL_TTF}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_SHARED_LIBS=OFF -DSDLTTF_SUPPORT_WEBP=OFF ${SDL_CMAKE} ${FREETYPE_CMAKE} ${SDL_TTF})


dk_visualStudio(${SDL_TTF_NAME} SDLTTF.sln SDLTTF)
#WIN_dk_visualStudio(${SDL_TTF_NAME} SDLTTF.sln SDLTTF)
dk_xcode(${SDL_TTF_NAME} SDLTTF)
#MAC_dk_xcode(${SDL_TTF_NAME} SDLTTF)
#IOS_dk_xcode(${SDL_TTF_NAME} SDLTTF)
#IOSSIM_dk_xcode(${SDL_TTF_NAME} SDLTTF)
LINUX_dk_queueCommand(make SDLTTF)
RASPBERRY_dk_queueCommand(make SDLTTF)
#ANDROID_dk_visualStudio(${SDL_TTF_NAME} SDLTTF.sln SDLTTF)
