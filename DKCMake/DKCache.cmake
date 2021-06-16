## https://stackoverflow.com/a/31044116/688352

## USAGE:  Place this cmake command into the command line for any DKCMake.txt build scripts using any of these these libraries
##	-C${DKCMAKE}/DKCache.cmake
##


MESSAGE("################ DKCache.cmake ##################")

#cmake_policy(SET CMP0074 NEW)
#SET(OS win32)
#project(HelloWorld C CXX)
set(3RDPARTY "C:/Users/$ENV{USERNAME}/digitalknob/DK/3rdParty" CACHE PATH "" FORCE)

##${STDINT}

set(ZLIB ${3RDPARTY}/zlib-1.2.11 CACHE PATH "" FORCE)
if(EXISTS ${ZLIB}/win32/Release/zlibstatic.lib)
	#INCLUDE_DIRECTORIES(${ZLIB})
	#INCLUDE_DIRECTORIES(${ZLIB}/win32)
	SET(ZLIB_INCLUDE_DIR ${ZLIB} CACHE PATH "" FORCE)
	SET(ZLIB_LIBRARY ${ZLIB}/win32/Release/zlibstatic.lib CACHE FILEPATH "" FORCE)
	SET(ZLIB_LIBRARY_DEBUG ${ZLIB}/win32/Debug/zlibstatic.lib CACHE FILEPATH "" FORCE)
	SET(ZLIB_LIBRARY_RELEASE ${ZLIB}/win32/Release/zlibstatic.lib CACHE FILEPATH "" FORCE)
	##list(APPEND CMAKE_PREFIX_PATH ${ZLIB})
	##find_package(ZLIB REQUIRED)
endif()

#EXECUTE_PROCESS(COMMAND cmd /c set /p DUMMY=Hit ENTER to continue... WORKING_DIRECTORY C:/)

set(BZIP2 ${3RDPARTY}/bzip2-1.0.6 CACHE PATH "" FORCE)
if(EXISTS ${BZIP2}/win32/libbz2.lib)
set(BZIP2_ROOT ${BZIP2} CACHE PATH "" FORCE)
set(BZIP2_INCLUDE_DIR ${BZIP2} CACHE PATH "" FORCE)
set(BZIP2_LIBRARY ${BZIP2}/win32/libbz2.lib CACHE FILEPATH "" FORCE)
set(BZIP2_LIBRARY_DEBUG ${BZIP2}/win32/libbz2.lib CACHE FILEPATH "" FORCE)
set(BZIP2_LIBRARY_RELEASE ${BZIP2}/win32/libbz2.lib CACHE FILEPATH "" FORCE)
set(LIBGCC_LIBRARY ${BZIP2}/win32/libgcc.lib CACHE FILEPATH "" FORCE)
#list(APPEND CMAKE_PREFIX_PATH ${BZIP2})
#find_package(BZip2 REQUIRED)
endif()


set(TIFF ${3RDPARTY}/tiff-4.0.3 CACHE PATH "" FORCE)
if(EXISTS ${TIFF}/win32/Release/tiff-static.lib)
	set(TIFF_INCLUDE_DIR ${TIFF}/libtiff CACHE PATH "" FORCE)
	set(TIFF_INCLUDE_DIR2 ${TIFF}/win32 CACHE PATH "" FORCE)
endif()


set(PNG ${3RDPARTY}/libpng-1.7.0beta34 CACHE PATH "" FORCE)
if(EXISTS ${PNG}/win32/Release/libpng17_static.lib)
	set(PNG_INCLUDE_DIR ${PNG} CACHE PATH "" FORCE)
	set(PNG_INCLUDE_DIR2 ${PNG}/win32 CACHE PATH "" FORCE)
endif()


set(JPEG ${3RDPARTY}/libjpeg-turbo-1.5.3 CACHE PATH "" FORCE)
if(EXISTS ${JPEG}/win32/Release/turbojpeg-static.lib)
	set(JPEG_INCLUDE_DIR ${JPEG} CACHE PATH "" FORCE)
	set(JPEG_INCLUDE_DIR2 ${JPEG}/win32 CACHE PATH "" FORCE)
endif()


set(GIF ${3RDPARTY}/ CACHE PATH "" FORCE)
if(EXISTS ${GIF}/win32/Release/lib/.libs/libgif.lib)
	set(GIF_INCLUDE_DIR ${GIF} CACHE PATH "" FORCE)
	set(GIF_INCLUDE_DIR2 ${GIF}/win32 CACHE PATH "" FORCE)
endif()


set(FREETYPE ${3RDPARTY}/freetype-2.5.5 CACHE PATH "" FORCE)
if(EXISTS ${FREETYPE}/win32/Release/freetype.lib)
	set(FREETYPE_INCLUDE_DIRS ${FREETYPE}/include CACHE PATH "" FORCE)
	set(FREETYPE_INCLUDE_DIR_freetype2 ${FREETYPE}/include CACHE PATH "" FORCE)
	set(FREETYPE_INCLUDE_DIR_ft2build ${FREETYPE}/include CACHE PATH "" FORCE)
	set(FREETYPE_LIBRARY ${FREETYPE}/win32/Release/freetype.lib CACHE FILEPATH "" FORCE)
	set(FREETYPE_LIBRARY_DEBUG ${FREETYPE}/win32/Debug/freetype.lib CACHE FILEPATH "" FORCE)
	set(FREETYPE_LIBRARY_RELEASE ${FREETYPE}/win32/Release/freetype.lib CACHE FILEPATH "" FORCE)
endif()

set(SDL2 ${3RDPARTY}/SDL2-2.0.14 CACHE PATH "" FORCE)
if(EXISTS ${SDL2}/win32/Release/SDL2.lib)
	set(SDL2_DIR ${SDL2} CACHE PATH "" FORCE)
	set(SDL2_INCLUDE_DIR ${SDL2}/include CACHE PATH "" FORCE)
	set(SDL2_LIBRARY_TEMP ${SDL2}/win32/Release/SDL2.lib CACHE FILEPATH "" FORCE)
	set(SDL2_LIBRARY ${SDL2}/win32/Release/SDL2.lib CACHE FILEPATH "" FORCE)
	set(SDL2_LIBRARY_DEBUG ${SDL2}/win32/Debug/SDL2d.lib CACHE FILEPATH "" FORCE)
	set(SDL2_LIBRARY_RELEASE ${SDL2}/win32/Release/SDL2.lib CACHE FILEPATH "" FORCE)
	set(SDL2MAIN_LIBRARY_TEMP ${SDL2}/win32/Release/SDL2main.lib CACHE FILEPATH "" FORCE)
	set(SDL2MAIN_LIBRARY ${SDL2}/win32/Release/SDL2main.lib CACHE FILEPATH "" FORCE)
	set(SDL2MAIN_LIBRARY_DEBUG ${SDL2}/win32/Debug/SDL2maind.lib CACHE FILEPATH "" FORCE)
	set(SDL2MAIN_LIBRARY_RELEASE ${SDL2}/win32/Release/SDL2main.lib CACHE FILEPATH "" FORCE)
endif()


set(SDL2_IMAGE ${3RDPARTY}/SDL2_image-2.0.1 CACHE PATH "" FORCE)
if(EXISTS ${SDL2_IMAGE}/win32/lib/Release/SDL_image.lib)
	set(SDL2_IMAGE_INCLUDE_DIR ${SDL2_IMAGE} CACHE PATH "" FORCE)
	set(SDL2_IMAGE_LIBRARY_TEMP ${SDL2_IMAGE}/win32/lib/Release/SDL_image.lib CACHE FILEPATH "" FORCE)
	set(SDL2_IMAGE_LIBRARY ${SDL2_IMAGE}/win32/lib/Release/SDL_image.lib CACHE FILEPATH "" FORCE)
	set(SDL2_IMAGE_LIBRARY_DEBUG ${SDL2_IMAGE}/win32/lib/Debug/SDL_image.lib CACHE FILEPATH "" FORCE)
	set(SDL2_IMAGE_LIBRARY_RELEASE ${SDL2_IMAGE}/win32/lib/Release/SDL_image.lib CACHE FILEPATH "" FORCE)
endif()


set(SFML ${3RDPARTY}/SFML-2.4.2 CACHE PATH "" FORCE)
if(EXISTS ${SFML}/win32/lib/Release/sfml-main.lib)
	set(SFML_INCLUDE_DIR ${SFML}/include CACHE FILEPATH "" FORCE)
	set(SFML_MAIN_LIBRARY_DEBUG ${SFML}/win32/lib/Debug/sfml-main-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_MAIN_LIBRARY_RELEASE ${SFML}/win32/lib/Release/sfml-main.lib CACHE FILEPATH "" FORCE)
	set(SFML_SYSTEM_LIBRARY_DEBUG ${SFML}/win32/lib/Debug/sfml-system-s-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_SYSTEM_LIBRARY_RELEASE ${SFML}/win32/lib/Debug/sfml-system-s.lib CACHE FILEPATH "" FORCE)
	set(SFML_WINDOW_LIBRARY_DEBUG ${SFML}/win32/lib/Debug/sfml-window-s-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_WINDOW_LIBRARY_RELEASE ${SFML}/win32/lib/Release/sfml-window-s.lib CACHE FILEPATH "" FORCE)
	set(SFML_GRAPHICS_LIBRARY_DEBUG ${SFML}/win32/lib/Debug/sfml-graphics-s-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_GRAPHICS_LIBRARY_RELEASE ${SFML}/win32/lib/Release/sfml-graphics-s.lib CACHE FILEPATH "" FORCE)
	set(SFML_AUDIO_LIBRARY_DEBUG ${SFML}/win32/lib/Debug/sfml-audio-s-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_AUDIO_LIBRARY_RELEASE ${SFML}/win32/lib/Release/sfml-audio-s.lib CACHE FILEPATH "" FORCE)
endif()

# https://cmake.org/cmake/help/latest/module/FindGLEW.html
set(GLEW ${3RDPARTY}/glew-2.2.0 CACHE PATH "" FORCE)
if(EXISTS ${GLEW}/win32/lib/Release/libglew32.lib)
	##set(GLEW_DIR ${GLEW}/build/cmake CACHE PATH "" FORCE)
	set(GLEW_USE_STATIC_LIBS ON CACHE BOOL "" FORCE)
	set(GLEW_DIR ${GLEW}/win32/CMakeFiles/Export/lib/cmake/glew CACHE PATH "" FORCE)
	set(GLEW_LIBRARY ${GLEW}/win32/lib/Debug/libglew32.lib CACHE FILEPATH "" FORCE)
	set(GLEW_INCLUDE_DIR ${GLEW} CACHE PATH "" FORCE)
	set(GLEW_STATIC_LIBRARY_DEBUG ${GLEW}/win32/lib/Debug/libglew32d.lib CACHE FILEPATH "" FORCE)
	set(GLEW_STATIC_LIBRARY_RELEASE ${GLEW}/win32/lib/Release/libglew32.lib CACHE FILEPATH "" FORCE)
	set(GLEW_SHARED_LIBRARY_DEBUG ${GLEW}/win32/lib/Debug/glew32d.lib CACHE FILEPATH "" FORCE)
	set(GLEW_SHARED_LIBRARY_RELEASE ${GLEW}/win32/lib/Release/glew32.lib CACHE FILEPATH "" FORCE)
	set(GLEW_LIBRARIES "${GLEW_STATIC_LIBRARY_DEBUG}" CACHE FILEPATH "" FORCE)
	set(GLEW_LIBRARIES ${GLEW_LIBRARIES} "${GLEW_STATIC_LIBRARY_RELEASE}" CACHE FILEPATH "" FORCE)
endif()


set(OPENSSL ${3RDPARTY}/openssl-1.0.2h-vs2015 CACHE PATH "" FORCE)
if(EXISTS ${OPENSSL}/lib/ssleay32MT.lib)
	set(CMAKE_USE_OPENSSL ON CACHE BOOL "" FORCE)
	set(OPENSSL_INCLUDE_DIR ${OPENSSL}/include CACHE PATH "" FORCE)
	set(LIB_EAY_DEBUG ${OPENSSL}/lib/libeay32MTd.lib CACHE FILEPATH "" FORCE)
	set(LIB_EAY_RELEASE ${OPENSSL}/lib/libeay32MT.lib CACHE FILEPATH "" FORCE)
	set(SSL_EAY_DEBUG ${OPENSSL}/lib/ssleay32MTd.lib CACHE FILEPATH "" FORCE)
	set(SSL_EAY_RELEAS ${OPENSSL}/lib/ssleay32MT.lib CACHE FILEPATH "" FORCE)
endif()


set(OPENAL ${3RDPARTY}/openal-1.15.1 CACHE PATH "" FORCE)
if(EXISTS ${OPENAL}/win32/Release/OpenAL32.lib)
# /I${OPENAL}/include/AL
	set(OPENAL_INCLUDE_DIR ${OPENAL}/include CACHE PATH "" FORCE)
	set(OPENAL_LIB_DIR ${OPENAL}/win32/Release CACHE PATH "" FORCE)
	set(OPENAL_INCLUDE_DIRS "${OPENAL_INCLUDE_DIR}" CACHE PATH "" FORCE)
	set(OPENAL_INCLUDE_DIRS "${OPENAL_INCLUDE_DIR}" "${OPENAL}/include/AL" CACHE PATH "" FORCE)
endif()


set(VORBIS ${3RDPARTY}/libvorbis-1.3.5 CACHE PATH "" FORCE)
if(EXISTS ${VORBIS}/win32/Release/lib/.libs/libvorbis.lib)
	set(VORBIS_INCLUDE_DIR ${VORBIS}/include CACHE PATH "" FORCE)
endif()


set(OGG ${3RDPARTY}/libogg-1.3.2 CACHE PATH "" FORCE)
if(EXISTS ${OGG}/win32/Release/src/.libs/libogg.lib)
	set(OGG_INCLUDE_DIR ${OGG}/include CACHE PATH "" FORCE)
endif()


set(SMPEG2 ${3RDPARTY}/smpeg2-2.0.0 CACHE PATH "" FORCE)
if(EXISTS ${SMPEG2}/${OS}/lib/Release/libsmpeg2.lib)
	set(SMPEG_INCLUDE_DIR=${SMPEG2} CACHE PATH "" FORCE)
endif()



