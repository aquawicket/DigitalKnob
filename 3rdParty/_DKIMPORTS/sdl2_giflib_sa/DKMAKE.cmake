#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/theMealena/SDL2_giflib_sa.git
# https://github.com/theMealena/SDL2_giflib_sa/archive/master.zip


### DEPEND ###
dk_depend(giflib)
dk_depend(sdl)


### IMPORT ###
#dk_import(https://github.com/theMealena/SDL2_giflib_sa.git)
dk_import(https://github.com/theMealena/SDL2_giflib_sa/archive/refs/heads/master.zip)


### LINK ###
#dk_define				(USE_SDL2_gif)
dk_include				(${SDL2_GIFLIB_SA})
if(MSVC)
	WIN_dk_libDebug		(${SDL2_GIFLIB_SA}/${triple}/${DEBUG_DIR}/SDL2_gif.lib)
	WIN_dk_libRelease	(${SDL2_GIFLIB_SA}/${triple}/${RELEASE_DIR}/SDL2_gif.lib)
else()
	dk_libDebug			(${SDL2_GIFLIB_SA}/${triple}/${DEBUG_DIR}/libSDL2_gif.a)
	dk_libRelease		(${SDL2_GIFLIB_SA}/${triple}/${RELEASE_DIR}/libSDL2_gif.a)
endif()



### GENERATE ###
dk_configure(${SDL2_GIFLIB_SA} ${GIFLIB_CMAKE} ${SDL_CMAKE})


### COMPILE ###
dk_build(${SDL2_GIFLIB_SA} SDL2_gif)	
