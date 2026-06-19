#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


###### sdl_net ######
# https://github.com/libsdl-org/SDL_net.git

dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
dk_depend(sdl)


### IMPORT ###
#dk_import(https://github.com/libsdl-org/SDL_net.git BRANCH main) # SDL3
dk_import(https://github.com/libsdl-org/SDL_net/archive/refs/tags/release-2.2.0.zip)



### LINK ###
dk_include				(${SDL_NET})
if(MSVC)
	Windows_dk_libDebug		(${SDL_NET_Debug_Dir}/SDL2_net-staticd.lib)
	Windows_dk_libRelease	(${SDL_NET_Release_Dir}/SDL2_net-static.lib)
elseif(Android)
	dk_libDebug			(${SDL_NET_Debug_Dir}/libSDL2_net.a)
	dk_libRelease		(${SDL_NET_Release_Dir}/libSDL2_net.a)
else()
	dk_libDebug			(${SDL_NET_Debug_Dir}/libSDL2_netd.a)
	dk_libRelease		(${SDL_NET_Release_Dir}/libSDL2_net.a)
endif()



### GENERATE ###
dk_configure(${SDL_NET} ${sdl_CMAKE})


### COMPILE ###
dk_build()
