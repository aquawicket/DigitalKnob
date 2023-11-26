# https://github.com/theMealena/SDL2_giflib_sa.git
# https://github.com/theMealena/SDL2_giflib_sa/archive/master.zip


### DEPEND ###
dk_depend(giflib)
dk_depend(sdl)


### IMPORT ###
dk_import(https://github.com/theMealena/SDL2_giflib_sa.git)


### LINK ###
#dk_define				(USE_SDL2_gif)
dk_include				(${SDL2_GIFLIB_SA})
UNIX_dk_libDebug		(${SDL2_GIFLIB_SA}/${OS}/${DEBUG_DIR}/libSDL2_gif.a)
UNIX_dk_libRelease		(${SDL2_GIFLIB_SA}/${OS}/${RELEASE_DIR}/libSDL2_gif.a)
WIN_dk_libDebug			(${SDL2_GIFLIB_SA}/${OS}/${DEBUG_DIR}/SDL2_gif.lib)
WIN_dk_libRelease		(${SDL2_GIFLIB_SA}/${OS}/${RELEASE_DIR}/SDL2_gif.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${GIFLIB_CMAKE} ${SDL_CMAKE} ${SDL2_GIFLIB_SA})


### COMPILE ###
dk_build(${SDL2_GIFLIB_SA} SDL2_gif)	
