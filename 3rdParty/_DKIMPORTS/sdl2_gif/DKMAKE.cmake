#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### sdl2_gif ######



### DEPEND ###
dk_depend(sdl)


### IMPORT ###
dk_validate(triple "dk_TARGET_TRIPLE()")
dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
dk_set			(SDL2_GIF_NAME SDL2_gif)
dk_set			(SDL2_GIF ${DK3RDPARTY_DIR}/${SDL2_GIF_NAME})
IF(NOT EXISTS ${SDL2_GIF})
	dk_extract	(${DKIMPORTS_DIR}/sdl2_gif/gif_2_lib.zip ${DK3RDPARTY_DIR})
	dk_rename	(${DK3RDPARTY_DIR}/SDL2    ${SDL2_GIF} OVERWRITE)
	dk_copy		(${DKIMPORTS_DIR}/sdl2_gif ${SDL2_GIF} OVERWRITE)
ENDIF()


### LINK ###
dk_define				(USE_SDL2_gif)
dk_include				(${SDL2_GIF})
if(MSVC)
	if(WIN)
		dk_libDebug		(${SDL2_GIF_DEBUG_DIR}/SDL2_gif.lib)
		dk_libRelease	(${SDL2_GIF_RELEASE_DIR}/SDL2_gif.lib)
	endif()
else()
	dk_libDebug			(${SDL2_GIF_DEBUG_DIR}/libSDL2_gif.a)
	dk_libRelease		(${SDL2_GIF_RELEASE_DIR}/libSDL2_gif.a)
endif()



### GENERATE ###
dk_configure(${SDL2_GIF} ${SDL_CMAKE})


### COMPILE ###
dk_build(${SDL2_GIF} SDL2_gif)
