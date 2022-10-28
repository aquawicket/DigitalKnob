# https://github.com/libsdl-org/SDL_net.git


### DEPEND ###
dk_depend(sdl)


### IMPORT ###
dk_import(https://github.com/libsdl-org/SDL_net.git BRANCH main)


### LINK ###
dk_include				(${SDL_NET})
WIN_dk_libDebug			(${SDL_NET}/${OS}/lib/${DEBUG_DIR}/SDL_net.lib)
WIN_dk_libRelease		(${SDL_NET}/${OS}/lib/${RELEASE_DIR}/SDL_net.lib)
UNIX_dk_libDebug		(${SDL_NET}/${OS}/${DEBUG_DIR}/libSDL2_netd.a)
UNIX_dk_libRelease		(${SDL_NET}/${OS}/${RELEASE_DIR}/libSDL2_net.a)


### GENERATE ###
dk_setPath		(${SDL_NET}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} ${SDL_CMAKE} ${SDL_NET})


### COMPILE ###
dk_build(${SDL_NET_FOLDER})
