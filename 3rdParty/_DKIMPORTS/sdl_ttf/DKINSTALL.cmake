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


###### sdl_ttf ######
# https://github.com/libsdl-org/SDL_ttf.git
# https://www.libsdl.org/projects/SDL_ttf
# https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.15.zip


### DEPEND ###
dk_depend(freetype)
dk_depend(libwebp)
dk_depend(sdl)


### IMPORT ###
#dk_import(https://github.com/libsdl-org/SDL_ttf.git BRANCH main PATCH) # SDL3
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import("${SDL_TTF_DL}" PATCH)



### LINK ###
dk_include			(${SDL_TTF})
if(MSVC)
	dk_libDebug		(${SDL_TTF_Config_Dir}/lib/${Debug_Dir}/SDL_ttf.lib)
	dk_libRelease	(${SDL_TTF_Config_Dir}/lib/${Release_Dir}/SDL_ttf.lib)
elseif(XCODE)
	dk_libDebug		(${SDL_TTF_Config_Dir}/lib/${Debug_Dir}/SDL_ttf.a)
	dk_libRelease	(${SDL_TTF_Config_Dir}/lib/${Release_Dir}/SDL_ttf.a)
else()
	dk_libDebug		(${SDL_TTF_Config_Dir}/lib/SDL_ttf.a)
	dk_libRelease	(${SDL_TTF_Config_Dir}/lib/SDL_ttf.a)
endif()


### GENERATE ###
dk_configure(${SDL_TTF}
	-DSDLTTF_SUPPORT_WEBP=${LIBWEBP}
	${FREETYPE_CMAKE}
	${LIBWEBP_CMAKE}
	${sdl_CMAKE}) 


### COMPILE ###
dk_build(${SDL_TTF} SDLTTF)
