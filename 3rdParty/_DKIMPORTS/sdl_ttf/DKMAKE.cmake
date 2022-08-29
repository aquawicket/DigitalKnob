# https://github.com/libsdl-org/SDL_ttf
# https://www.libsdl.org/projects/SDL_ttf
# https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.15.zip


dk_depend(sdl)
dk_depend(freetype)

dk_import(https://github.com/libsdl-org/SDL_ttf/archive/455d885c33dd26a21486bc2a2ede51aca4541679.zip PATCH)
#dk_import(https://github.com/libsdl-org/SDL_ttf/archive/06f1158066a5556f074fe020e407e6efcc9ff8e1.zip PATCH)
#dk_import(https://github.com/libsdl-org/SDL_ttf.git main PATCH)


### LINK ###
dk_include				(${SDL_TTF})
WIN_dk_libDebug			(${SDL_TTF}/${OS}/lib/${DEBUG_DIR}/SDL_ttf.lib)
WIN_dk_libRelease		(${SDL_TTF}/${OS}/lib/${RELEASE_DIR}/SDL_ttf.lib)
APPLE_dk_libDebug		(${SDL_TTF}/${OS}/lib/${DEBUG_DIR}/SDL_ttf.a)
APPLE_dk_libRelease		(${SDL_TTF}/${OS}/lib/${RELEASE_DIR}/SDL_ttf.a)
LINUX_dk_libDebug		(${SDL_TTF}/${OS}/${DEBUG_DIR}/lib/SDL_ttf.a)
LINUX_dk_libRelease		(${SDL_TTF}/${OS}/${RELEASE_DIR}/lib/SDL_ttf.a)
RASPBERRY_dk_libDebug	(${SDL_TTF}/${OS}/${DEBUG_DIR}/lib/SDL_ttf.a)
RASPBERRY_dk_libRelease	(${SDL_TTF}/${OS}/${RELEASE_DIR}/lib/SDL_ttf.a)
ANDROID_dk_libDebug		(${SDL_TTF}/${OS}/lib/${DEBUG_DIR}/SDL_ttf.a)
ANDROID_dk_libRelease	(${SDL_TTF}/${OS}/lib/${RELEASE_DIR}/SDL_ttf.a)


### GENERATE ###
dk_setPath		(${SDL_TTF}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} -DBUILD_SHARED_LIBS=OFF -DSDLTTF_SUPPORT_WEBP=OFF ${SDL_CMAKE} ${FREETYPE_CMAKE} ${SDL_TTF})


### COMPILE ###
dk_visualStudio				(${SDL_TTF_NAME} SDLTTF)
dk_xcode					(${SDL_TTF_NAME} SDLTTF)
LINUX_dk_queueCommand		(make SDLTTF)
RASPBERRY_dk_queueCommand	(make SDLTTF)
