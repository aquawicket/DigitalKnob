# https://github.com/libsdl-org/SDL_ttf.git
# https://www.libsdl.org/projects/SDL_ttf
# https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.15.zip


### DEPEND ###
dk_depend(libwebp)
dk_depend(freetype)
dk_depend(sdl)


### IMPORT ###
dk_import(https://github.com/libsdl-org/SDL_ttf/archive/455d885c33dd26a21486bc2a2ede51aca4541679.zip PATCH)
#dk_import(https://github.com/libsdl-org/SDL_ttf/archive/06f1158066a5556f074fe020e407e6efcc9ff8e1.zip PATCH)
#dk_import(https://github.com/libsdl-org/SDL_ttf.git BRANCH main PATCH)


### LINK ###
dk_include				(${SDL_TTF})
WIN_dk_libDebug			(${SDL_TTF}/${OS}/lib/${DEBUG_DIR}/SDL_ttf.lib)
WIN_dk_libRelease		(${SDL_TTF}/${OS}/lib/${RELEASE_DIR}/SDL_ttf.lib)
MAC_dk_libDebug			(${SDL_TTF}/${OS}/lib/${DEBUG_DIR}/SDL_ttf.a)
MAC_dk_libRelease		(${SDL_TTF}/${OS}/lib/${RELEASE_DIR}/SDL_ttf.a)
IOSSIM_dk_libDebug		(${SDL_TTF}/${OS}/lib/Debug/SDL_ttf.a)
IOSSIM_dk_libRelease	(${SDL_TTF}/${OS}/lib/Release/SDL_ttf.a)
LINUX_dk_libDebug		(${SDL_TTF}/${OS}/${DEBUG_DIR}/lib/SDL_ttf.a)
LINUX_dk_libRelease		(${SDL_TTF}/${OS}/${RELEASE_DIR}/lib/SDL_ttf.a)
RASPBERRY_dk_libDebug	(${SDL_TTF}/${OS}/${DEBUG_DIR}/lib/SDL_ttf.a)
RASPBERRY_dk_libRelease	(${SDL_TTF}/${OS}/${RELEASE_DIR}/lib/SDL_ttf.a)
ANDROID_dk_libDebug		(${SDL_TTF}/${OS}/lib/${DEBUG_DIR}/SDL_ttf.a)
ANDROID_dk_libRelease	(${SDL_TTF}/${OS}/lib/${RELEASE_DIR}/SDL_ttf.a)


### GENERATE ###
dk_setPath		(${SDL_TTF}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} ${FREETYPE_CMAKE} ${LIBWEBP_CMAKE} ${SDL_CMAKE} ${SDL_TTF}) # -DSDLTTF_SUPPORT_WEBP=OFF


### COMPILE ###
dk_build(${SDL_TTF_FOLDER} SDLTTF)
