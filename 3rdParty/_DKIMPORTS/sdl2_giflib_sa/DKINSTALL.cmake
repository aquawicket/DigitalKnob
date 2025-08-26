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


###### sdl2_giflib_sa ######
# https://github.com/theMealena/SDL2_giflib_sa.git
# https://github.com/theMealena/SDL2_giflib_sa/archive/master.zip

dk_validate(Target_Tuple "dk_Target_Tuple()")

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
	Windows_dk_libDebug		(${SDL2_GIFLIB_SA_Debug_Dir}/SDL2_gif.lib)
	Windows_dk_libRelease	(${SDL2_GIFLIB_SA_Release_Dir}/SDL2_gif.lib)
else()
	dk_libDebug			(${SDL2_GIFLIB_SA_Debug_Dir}/libSDL2_gif.a)
	dk_libRelease		(${SDL2_GIFLIB_SA_Release_Dir}/libSDL2_gif.a)
endif()



### GENERATE ###
dk_configure(${SDL2_GIFLIB_SA} ${GIFLIB_CMAKE} ${SDL_CMAKE})


### COMPILE ###
dk_build(${SDL2_GIFLIB_SA} SDL2_gif)	
