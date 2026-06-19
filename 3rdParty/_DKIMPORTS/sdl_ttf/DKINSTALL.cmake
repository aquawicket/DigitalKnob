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


###### sdl_ttf ######
# https://github.com/libsdl-org/SDL_ttf.git
# https://www.libsdl.org/projects/SDL_ttf
# https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.15.zip

dk_depend(freetype)
dk_depend(libwebp)
dk_depend(sdl)

dk_import()

dk_include			(${sdl_ttf})
if(MSVC)
	dk_libDebug		(${sdl_ttf_Config_Dir}/lib/${Debug_Dir}/SDL_ttf.lib)
	dk_libRelease	(${sdl_ttf_Config_Dir}/lib/${Release_Dir}/SDL_ttf.lib)
elseif(XCODE)
	dk_libDebug		(${sdl_ttf_Config_Dir}/lib/${Debug_Dir}/SDL_ttf.a)
	dk_libRelease	(${sdl_ttf_Config_Dir}/lib/${Release_Dir}/SDL_ttf.a)
else()
	dk_libDebug		(${sdl_ttf_Config_Dir}/lib/SDL_ttf.a)
	dk_libRelease	(${sdl_ttf_Config_Dir}/lib/SDL_ttf.a)
endif()

dk_configure(${sdl_ttf}
	-DSDLTTF_SUPPORT_WEBP=${libwebp}
	${freetype_CMAKE}
	${libwebp_CMAKE}
	${sdl_CMAKE}) 

dk_build(${sdl_ttf} SDLTTF)
