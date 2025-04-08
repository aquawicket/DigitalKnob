#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### sdl_net ######
# https://github.com/libsdl-org/SDL_net.git

dk_load(dk_builder)

### DEPEND ###
dk_depend(sdl)


### IMPORT ###
#dk_import(https://github.com/libsdl-org/SDL_net.git BRANCH main) # SDL3
dk_import(https://github.com/libsdl-org/SDL_net/archive/refs/tags/release-2.2.0.zip)



### LINK ###
dk_include				(${SDL_NET_DIR})
if(MSVC)
	WIN_dk_libDebug		(${SDL_NET_DEBUG_DIR}/SDL2_net-staticd.lib)
	WIN_dk_libRelease	(${SDL_NET_RELEASE_DIR}/SDL2_net-static.lib)
elseif(ANDROID)
	dk_libDebug			(${SDL_NET_DEBUG_DIR}/libSDL2_net.a)
	dk_libRelease		(${SDL_NET_RELEASE_DIR}/libSDL2_net.a)
else()
	dk_libDebug			(${SDL_NET_DEBUG_DIR}/libSDL2_netd.a)
	dk_libRelease		(${SDL_NET_RELEASE_DIR}/libSDL2_net.a)
endif()



### GENERATE ###
dk_configure(${SDL_NET} ${SDL_CMAKE})


### COMPILE ###
dk_build(${SDL_NET})
