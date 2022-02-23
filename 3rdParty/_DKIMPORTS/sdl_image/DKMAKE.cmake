# https://github.com/libsdl-org/SDL_image
# https://github.com/aquawicket/SDL_image
#
# https://github.com/aquawicket/SDL_image/archive/refs/heads/main.zip
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



### DEPENDS ###
if(IOS OR IOSSIM)
	DKDEPEND(imageio)
	DKDEPEND(mobile_core_services)
endif()
DKDEPEND(zlib)
DKDEPEND(giflib)
DKDEPEND(libpng)
DKDEPEND(libjpeg-turbo)
DKDEPEND(libwebp)
DKDEPEND(tiff)
DKDEPEND(sdl)


#DKIMPORT(https://github.com/libsdl-org/SDL_image)
DKIMPORT(https://github.com/libsdl-org/SDL_image/archive/fc370dc71d7726023c063618c7b04c1ed30637e2.zip PATCH)
#DKSET(SDL_IMAGE_VERSION main)
#DKSET(SDL_IMAGE_NAME SDL2_image-${SDL_IMAGE_VERSION})
#DKSET(SDL_IMAGE_DL https://github.com/aquawicket/SDL_image/archive/refs/heads/${SDL_IMAGE_VERSION}.zip)
#DKSET(SDL_IMAGE ${3RDPARTY}/${SDL_IMAGE_NAME})
#DKINSTALL(${SDL_IMAGE_DL} sdl_image ${SDL_IMAGE}) #NOPATCH)


### DKPLUGINS LINK ###
DKINCLUDE(${SDL_IMAGE})
WIN_DEBUG_DKLIB(${SDL_IMAGE}/${OS}/lib/${DEBUG_DIR}/SDL_image.lib)
WIN_RELEASE_DKLIB(${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.lib)
APPLE_DEBUG_DKLIB(${SDL_IMAGE}/${OS}/lib/Debug/SDL_image.a)
APPLE_RELEASE_DKLIB(${SDL_IMAGE}/${OS}/lib/Release/SDL_image.a)
LINUX_DEBUG_DKLIB(${SDL_IMAGE}/${OS}/${DEBUG_DIR}/lib/SDL_image.a)
LINUX_RELEASE_DKLIB(${SDL_IMAGE}/${OS}/${RELEASE_DIR}/lib/SDL_image.a)
RASPBERRY_DEBUG_DKLIB(${SDL_IMAGE}/${OS}/${DEBUG_DIR}/lib/SDL_image.a)
RASPBERRY_RELEASE_DKLIB(${SDL_IMAGE}/${OS}/${RELEASE_DIR}/lib/SDL_image.a)
ANDROID_DEBUG_DKLIB(${SDL_IMAGE}/${OS}/lib/${DEBUG_DIR}/SDL_image.a)
ANDROID_RELEASE_DKLIB(${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.a)


### 3RDPARTY LINK ###
WIN_DKSET(SDL_IMAGE_CMAKE 
-DSDL2_IMAGE_INCLUDE_DIR=${SDL_IMAGE}
-DSDL2_IMAGE_LIBRARY_TEMP=${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.lib
-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL_IMAGE}/${OS}/lib/${DEBUG_DIR}/SDL_image.lib 
-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.lib)
APPLE_DKSET(SDL_IMAGE_CMAKE 
-DSDL2_IMAGE_INCLUDE_DIR=${SDL_IMAGE}
-DSDL2_IMAGE_LIBRARY_TEMP=${SDL_IMAGE}/${OS}/lib/Debug/SDL_image.a
-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL_IMAGE}/${OS}/lib/Debug/SDL_image.a 
-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL_IMAGE}/${OS}/lib/Release/SDL_image.a)
LINUX_DKSET(SDL_IMAGE_CMAKE 
-DSDL2_IMAGE_INCLUDE_DIR=${SDL_IMAGE} 
-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL_IMAGE}/${OS}/lib/${DEBUG_DIR}/SDL_image.a 
-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.a)
RASPBERRY_DKSET(SDL_IMAGE_CMAKE 
-DSDL2_IMAGE_INCLUDE_DIR=${SDL_IMAGE} 
-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL_IMAGE}/${OS}/lib/${DEBUG_DIR}/SDL_image.a 
-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.a)
ANDROID_DKSET(SDL_IMAGE_CMAKE
-DSDL2_IMAGE_INCLUDE_DIR=${SDL_IMAGE} 
-DSDL2_IMAGE_LIBRARY_DEBUG=${SDL_IMAGE}/${OS}/lib/${DEBUG_DIR}/SDL_image.a 
-DSDL2_IMAGE_LIBRARY_RELEASE=${SDL_IMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.a)


### COMPILE ###
DKSETPATH(${SDL_IMAGE}/${BUILD_DIR})
DKQCOMMAND(${DKCMAKE_BUILD} -DSDLIMAGE_SUPPORT_GIF=ON -DSDLIMAGE_SUPPORT_JPEG=ON -DSDLIMAGE_SUPPORT_PNG=ON -DSDLIMAGE_SUPPORT_WEBP=OFF ${SDL_CMAKE} ${ZLIB_CMAKE} ${TIFF_CMAKE} ${LIBPNG_CMAKE} ${LIBJPEG-TURBO_CMAKE} ${GIF_CMAKE} ${SDL_IMAGE})

WIN_VS(${SDL_IMAGE_NAME} SDLIMAGE.sln SDLIMAGE)
MAC_XCODE(${SDL_IMAGE_NAME} SDLIMAGE)
IOS_XCODE(${SDL_IMAGE_NAME} SDLIMAGE)
IOSSIM_XCODE(${SDL_IMAGE_NAME} SDLIMAGE)
LINUX_DKQCOMMAND(make SDLIMAGE)
RASPBERRY_DKQCOMMAND(make SDLIMAGE)	
ANDROID_VS(${SDL_IMAGE_NAME} SDLIMAGE.sln SDLIMAGE)
