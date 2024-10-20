#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/libsdl-org/SDL_image
#
# https://github.com/libsdl-org/SDL_image/archive/refs/heads/main.zip
# https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.1.zip
# https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.5.zip
#
# Notes:  VS compiler options
#
# DEBUG flags
# Debug Information Format:         C7 compatible (/Z7)
# Enable Enhanced Instruction Set:  Streaming SIMD Extensions (/arch:SSE)
# Inline function expansion:        Default
# Preprocessor Definitions:         _DEBUG WIN_X86 _WINDOWS LOAD_BMP LOAD_GIF LOAD_JPG LOAD_LBM LOAD_PCX LOAD_PNG LOAD_PNM LOAD_SVG LOAD_TGA LOAD_TIF LOAD_WEBP LOAD_XPM LOAD_XV 
#
# RELEASE flags)
# Debug information format:         Program Database (/Zi)
# Diagnostics Format:               OFF
# Enable C++ Exceptions             Yes (/EHsc)
# Inline function expansion         Any Suitable (/Ob2)
# Ommit frame pointers              OFF


### DEPEND ###
dk_depend(giflib)
dk_depend(imageio)
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(libwebp)
dk_depend(mobile_core_services)
dk_depend(sdl)
dk_depend(tiff)
dk_depend(zlib)


### IMPORT ###
#dk_import(https://github.com/libsdl-org/SDL_image.git BRANCH main PATCH) # SDL3
dk_getFileParam("${DKIMPORTS_DIR}/sdl_image/sdl_image.txt" VERSION)
dk_import(https://github.com/libsdl-org/SDL_image/archive/refs/tags/release-${VERSION}.zip PATCH)



### LINK ###
dk_include					(${SDL_IMAGE_DIR}											SDL2_IMAGE_INCLUDE_DIR)
if(MSVC)
	ANDROID_dk_libDebug		(${SDL_IMAGE_CONFIG_DIR}/lib/${DEBUG_DIR}/SDL_image.a		SDL2_IMAGE_LIBRARY_DEBUG)
	ANDROID_dk_libRelease	(${SDL_IMAGE_CONFIG_DIR}/lib/${RELEASE_DIR}/SDL_image.a		SDL2_IMAGE_LIBRARY_RELEASE)
	WIN_dk_libDebug			(${SDL_IMAGE_CONFIG_DIR}/lib/${DEBUG_DIR}/SDL_image.lib		SDL2_IMAGE_LIBRARY_DEBUG)
	WIN_dk_libRelease		(${SDL_IMAGE_CONFIG_DIR}/lib/${RELEASE_DIR}/SDL_image.lib	SDL2_IMAGE_LIBRARY_RELEASE)
elseif(APPLE)
	dk_libDebug				(${SDL_IMAGE_CONFIG_DIR}/lib/Debug/SDL_image.a				SDL2_IMAGE_LIBRARY_DEBUG)
	dk_libRelease			(${SDL_IMAGE_CONFIG_DIR}/lib/Release/SDL_image.a			SDL2_IMAGE_LIBRARY_RELEASE)
else()
	dk_libDebug				(${SDL_IMAGE_CONFIG_DIR}/lib/SDL_image.a					SDL2_IMAGE_LIBRARY_DEBUG)
	dk_libRelease			(${SDL_IMAGE_CONFIG_DIR}/lib/SDL_image.a					SDL2_IMAGE_LIBRARY_RELEASE)
endif()


### 3RDPARTY LINK ###
#dk_set(SDL_IMAGE_CMAKE
#	-DSDL2_IMAGE_INCLUDE_DIR=${SDL2_IMAGE_INCLUDE_DIR}
#	-DSDL2_IMAGE_LIBRARY=${SDL2_IMAGE_LIBRARY_DEBUG}
#	-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL2_IMAGE_LIBRARY_DEBUG}
#	-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL2_IMAGE_LIBRARY_RELEASE}
#	-DSDL2_IMAGE_LIBRARY_TEMP=${SDL2_IMAGE_LIBRARY_RELEASE})
	
DEBUG_dk_set(SDL_IMAGE_CMAKE
	-DSDL2_IMAGE_INCLUDE_DIR=${SDL2_IMAGE_INCLUDE_DIR}
	-DSDL2_IMAGE_LIBRARY=${SDL2_IMAGE_LIBRARY_DEBUG}
	-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL2_IMAGE_LIBRARY_DEBUG}
	-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL2_IMAGE_LIBRARY_RELEASE}
	-DSDL2_IMAGE_LIBRARY_TEMP=${SDL2_IMAGE_LIBRARY_RELEASE}
	"-DCMAKE_EXE_LINKER_FLAGS=${SDL2_IMAGE_LIBRARY_DEBUG}")
	
RELEASE_dk_set(SDL_IMAGE_CMAKE
	-DSDL2_IMAGE_INCLUDE_DIR=${SDL2_IMAGE_INCLUDE_DIR}
	-DSDL2_IMAGE_LIBRARY=${SDL2_IMAGE_LIBRARY_RELEASE}
	-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL2_IMAGE_LIBRARY_DEBUG}
	-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL2_IMAGE_LIBRARY_RELEASE}
	-DSDL2_IMAGE_LIBRARY_TEMP=${SDL2_IMAGE_LIBRARY_RELEASE}
	"-DCMAKE_EXE_LINKER_FLAGS=${SDL2_IMAGE_LIBRARY_RELEASE}")


### GENERATE ###
dk_configure(${SDL_IMAGE_DIR}
	-DSDLIMAGE_SUPPORT_GIF=${GIFLIB}
	-DSDLIMAGE_SUPPORT_JPEG=${LIBJPEG_TURBO}
	-DSDLIMAGE_SUPPORT_PNG=${LIBPNG}
	-DSDLIMAGE_SUPPORT_WEBP=${LIBWEBP}
	${GIFLIB_CMAKE}
	${LIBJPEG_TURBO_CMAKE}
	${LIBPNG_CMAKE}
	${SDL_CMAKE}
	${TIFF_CMAKE}
	${ZLIB_CMAKE})


### COMPILE ###
dk_build(${SDL_IMAGE_DIR} SDLIMAGE)
