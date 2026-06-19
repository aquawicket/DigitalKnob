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


###### sdl2_gif ######


dk_depend(sdl)

dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
dk_set			(sdl2_gif_NAME SDL2_gif)
dk_set			(sdl2_gif ${DK3RDPARTY_DIR}/${sdl2_gif_NAME})
if(NOT EXISTS ${sdl2_gif})
	dk_extract	(${DKIMPORTS_DIR}/sdl2_gif/gif_2_lib.zip ${DK3RDPARTY_DIR})
	dk_rename	(${DK3RDPARTY_DIR}/SDL2    ${sdl2_gif} OVERWRITE)
	dk_copy		(${DKIMPORTS_DIR}/sdl2_gif ${sdl2_gif} OVERWRITE)
ENDIF()


### LINK ###
dk_define				(USE_SDL2_gif)
dk_include				(${sdl2_gif})
if(Windows AND MSVC)
	dk_libDebug			(${sdl2_gif_Debug_Dir}/SDL2_gif.lib)
	dk_libRelease		(${sdl2_gif_Release_Dir}/SDL2_gif.lib)
else()
	dk_libDebug			(${sdl2_gif_Debug_Dir}/libSDL2_gif.a)
	dk_libRelease		(${sdl2_gif_Release_Dir}/libSDL2_gif.a)
endif()



### GENERATE ###
dk_configure(${sdl2_gif} ${sdl_CMAKE})


### COMPILE ###
dk_build(${sdl2_gif} sdl2_gif)
