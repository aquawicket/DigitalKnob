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


###### sdl2_giflib_sa ######
# https://github.com/theMealena/SDL2_giflib_sa.git
# https://github.com/theMealena/SDL2_giflib_sa/archive/master.zip
# https://github.com/theMealena/SDL2_giflib_sa/archive/refs/heads/master.zip

dk_depend(giflib)
dk_depend(sdl)

dk_import()

#dk_define				(USE_SDL2_gif)
dk_include				(${sdl2_giflib_sa})
if(Windows AND MSVC)
	dk_libDebug			(${sdl2_giflib_sa_Debug_Dir}/SDL2_gif.lib)
	dk_libRelease		(${sdl2_giflib_sa_Release_Dir}/SDL2_gif.lib)
else()
	dk_libDebug			(${sdl2_giflib_sa_Debug_Dir}/libSDL2_gif.a)
	dk_libRelease		(${sdl2_giflib_sa_Release_Dir}/libSDL2_gif.a)
endif()

dk_configure(${sdl2_giflib_sa} ${giflib_CMAKE} ${sdl_CMAKE})

dk_build(${sdl2_giflib_sa} SDL2_gif)	
