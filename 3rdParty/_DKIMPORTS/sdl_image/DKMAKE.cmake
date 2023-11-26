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
# Preprocessor Definitions:         _DEBUG WIN32 _WINDOWS LOAD_BMP LOAD_GIF LOAD_JPG LOAD_LBM LOAD_PCX LOAD_PNG LOAD_PNM LOAD_SVG LOAD_TGA LOAD_TIF LOAD_WEBP LOAD_XPM LOAD_XV 
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
dk_import(https://github.com/libsdl-org/SDL_image/archive/refs/tags/release-2.6.2.zip PATCH)
#dk_import(https://github.com/libsdl-org/SDL_image.git BRANCH main PATCH) # SDL3


### LINK ###
dk_include					(${SDL_IMAGE})
if(VISUAL_STUDIO_IDE)
	ANDROID_dk_libDebug		(${SDL_IMAGE}/${OS}/lib/${DEBUG_DIR}/SDL_image.a)
	ANDROID_dk_libRelease	(${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.a)
	WIN_dk_libDebug			(${SDL_IMAGE}/${OS}/lib/${DEBUG_DIR}/SDL_image.lib)
	WIN_dk_libRelease		(${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.lib)
elseif(XCODE_IDE)
	dk_libDebug				(${SDL_IMAGE}/${OS}/lib/Debug/SDL_image.a)
	dk_libRelease			(${SDL_IMAGE}/${OS}/lib/Release/SDL_image.a)
else()
	dk_libDebug				(${SDL_IMAGE}/${OS}/${DEBUG_DIR}/lib/SDL_image.a)
	dk_libRelease			(${SDL_IMAGE}/${OS}/${RELEASE_DIR}/lib/SDL_image.a)
endif()


### 3RDPARTY LINK ###
ANDROID_dk_set(SDL_IMAGE_CMAKE
	-DSDL2_IMAGE_INCLUDE_DIR=${SDL_IMAGE} 
	-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL_IMAGE}/${OS}/lib/${DEBUG_DIR}/SDL_image.a 
	-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.a)
APPLE_dk_set(SDL_IMAGE_CMAKE 
	-DSDL2_IMAGE_INCLUDE_DIR=${SDL_IMAGE}
	-DSDL2_IMAGE_LIBRARY_TEMP=${SDL_IMAGE}/${OS}/lib/Debug/SDL_image.a
	-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL_IMAGE}/${OS}/lib/Debug/SDL_image.a 
	-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL_IMAGE}/${OS}/lib/Release/SDL_image.a)
EMSCRIPTEN_dk_set(SDL_IMAGE_CMAKE 
	-DSDL2_IMAGE_INCLUDE_DIR=${SDL_IMAGE} 
	-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL_IMAGE}/${OS}/lib/${DEBUG_DIR}/SDL_image.a 
	-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.a)
LINUX_dk_set(SDL_IMAGE_CMAKE 
	-DSDL2_IMAGE_INCLUDE_DIR=${SDL_IMAGE} 
	-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL_IMAGE}/${OS}/lib/${DEBUG_DIR}/SDL_image.a 
	-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.a)
RASPBERRY_dk_set(SDL_IMAGE_CMAKE 
	-DSDL2_IMAGE_INCLUDE_DIR=${SDL_IMAGE} 
	-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL_IMAGE}/${OS}/lib/${DEBUG_DIR}/SDL_image.a 
	-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.a)
WIN_dk_set(SDL_IMAGE_CMAKE 
	-DSDL2_IMAGE_INCLUDE_DIR=${SDL_IMAGE}
	-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL_IMAGE}/${OS}/lib/${DEBUG_DIR}/SDL2_image.lib
	-DSDL2_IMAGE_LIBRARY_TEMP=${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL2_image.lib
	-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL2_image.lib)	


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD}
	-DSDLIMAGE_SUPPORT_GIF=ON
	-DSDLIMAGE_SUPPORT_JPEG=ON
	-DSDLIMAGE_SUPPORT_PNG=ON
	-DSDLIMAGE_SUPPORT_WEBP=OFF
	${GIFLIB_CMAKE}
	${LIBJPEG-TURBO_CMAKE}
	${LIBPNG_CMAKE}
	${SDL_CMAKE}
	${TIFF_CMAKE}
	${ZLIB_CMAKE}
	${SDL_IMAGE})


### COMPILE ###
dk_build(${SDL_IMAGE} SDLIMAGE)
