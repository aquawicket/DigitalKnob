#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


###### sdl2_gif ######



### DEPEND ###
dk_depend(sdl)


### IMPORT ###
dk_validate(Target_Tuple "dk_Target_Tuple()")
dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
dk_set			(SDL2_GIF_NAME SDL2_gif)
dk_set			(SDL2_GIF $ENV{DK3RDPARTY_DIR}/${SDL2_GIF_NAME})
if(NOT EXISTS ${SDL2_GIF})
	dk_extract	($ENV{DKIMPORTS_DIR}/sdl2_gif/gif_2_lib.zip $ENV{DK3RDPARTY_DIR})
	dk_rename	($ENV{DK3RDPARTY_DIR}/SDL2    ${SDL2_GIF} OVERWRITE)
	dk_copy		($ENV{DKIMPORTS_DIR}/sdl2_gif ${SDL2_GIF} OVERWRITE)
ENDIF()


### LINK ###
dk_define				(USE_SDL2_gif)
dk_include				(${SDL2_GIF})
if(MSVC)
	if(Windows)
		dk_libDebug		(${SDL2_GIF.Debug_Dir}/SDL2_gif.lib)
		dk_libRelease	(${SDL2_GIF.Release_Dir}/SDL2_gif.lib)
	endif()
else()
	dk_libDebug			(${SDL2_GIF.Debug_Dir}/libSDL2_gif.a)
	dk_libRelease		(${SDL2_GIF.Release_Dir}/libSDL2_gif.a)
endif()



### GENERATE ###
dk_configure(${SDL2_GIF} ${SDL_CMAKE})


### COMPILE ###
dk_build(${SDL2_GIF} SDL2_gif)
