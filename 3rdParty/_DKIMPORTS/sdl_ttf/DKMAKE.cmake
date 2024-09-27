#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/libsdl-org/SDL_ttf.git
# https://www.libsdl.org/projects/SDL_ttf
# https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.15.zip


### DEPEND ###
dk_depend(freetype)
dk_depend(libwebp)
dk_depend(sdl)


### IMPORT ###
#dk_import(https://github.com/libsdl-org/SDL_ttf.git BRANCH main PATCH) # SDL3
dk_import(https://github.com/libsdl-org/SDL_ttf/archive/refs/tags/release-2.20.1.zip PATCH)



### LINK ###
dk_include				(${SDL_TTF_DIR})
if(MSVC)
	dk_libDebug			(${SDL_TTF_CONFIG_DIR}/lib/${DEBUG_DIR}/SDL_ttf.lib)
	dk_libRelease		(${SDL_TTF_CONFIG_DIR}/lib/${RELEASE_DIR}/SDL_ttf.lib)
elseif(XCODE)
	dk_libDebug			(${SDL_TTF_CONFIG_DIR}/lib/${DEBUG_DIR}/SDL_ttf.a)
	dk_libRelease		(${SDL_TTF_CONFIG_DIR}/lib/${RELEASE_DIR}/SDL_ttf.a)
else()
	dk_libDebug			(${SDL_TTF_CONFIG_DIR}/lib/SDL_ttf.a)
	dk_libRelease		(${SDL_TTF_CONFIG_DIR}/lib/SDL_ttf.a)
endif()


### GENERATE ###
dk_configure(${SDL_TTF}
	-DSDLTTF_SUPPORT_WEBP=${LIBWEBP}
	${FREETYPE_CMAKE}
	${LIBWEBP_CMAKE}
	${SDL_CMAKE}) 


### COMPILE ###
dk_build(${SDL_TTF} SDLTTF)
