## https://stackoverflow.com/a/31044116/688352

## USAGE:  Place this cmake command into the command line for any DKMAKE.cmake build scripts using any of these these libraries
##	-C${DKCMAKE_DIR}/DKCache.cmake
##
## Also note that cmake DOES accept multiple -C'cacheFile' commands at a time, so we can split these up later.
dk_return()

MESSAGE("################ DKCache.cmake ##################")
message("WARNING: DKCache.cmake will be discontinued.")
dk_return()
MESSAGE("OS: ${OS}")
if(NOT OS)
	message(FATAL_ERROR "The OS variable has not been set for DKCache.cmake")
endif()

#cmake_policy(SET CMP0074 NEW)
#project(HelloWorld C CXX)
##set(OS win_x86 CACHE PATH "" FORCE)
set(DK3RDPARTY_DIR "C:/Users/$ENV{USERNAME}/digitalknob/Development/3rdParty" CACHE PATH "" FORCE)

##${STDINT}

set(ZLIB ${DK3RDPARTY_DIR}/zlib-1.2.11 CACHE PATH "" FORCE)
if(EXISTS ${ZLIB}/${target_triple}/Release/zlibstatic.lib)
	set(ZLIB_INCLUDE_DIR ${ZLIB} CACHE PATH "" FORCE)
	set(ZLIB_LIBRARY ${ZLIB}/${target_triple}/Release/zlibstatic.lib CACHE FILEPATH "" FORCE)
	set(ZLIB_LIBRARY_DEBUG ${ZLIB}/${target_triple}/Debug/zlibstatic.lib CACHE FILEPATH "" FORCE)
	set(ZLIB_LIBRARY_RELEASE ${ZLIB}/${target_triple}/Release/zlibstatic.lib CACHE FILEPATH "" FORCE)
endif()

#execute_process(COMMAND ${CMD_EXE} /c set /p DUMMY=Hit ENTER to continue... WORKING_DIRECTORY C:/)

set(BZIP2 ${DK3RDPARTY_DIR}/bzip2-1.0.6 CACHE PATH "" FORCE)
if(EXISTS ${BZIP2}/${target_triple}/libbz2.lib)
	set(BZIP2_ROOT ${BZIP2} CACHE PATH "" FORCE)
	set(BZIP2_INCLUDE_DIR ${BZIP2} CACHE PATH "" FORCE)
	set(BZIP2_LIBRARY ${BZIP2}/${target_triple}/libbz2.lib CACHE FILEPATH "" FORCE)
	set(BZIP2_LIBRARY_DEBUG ${BZIP2}/${target_triple}/libbz2.lib CACHE FILEPATH "" FORCE)
	set(BZIP2_LIBRARY_RELEASE ${BZIP2}/${target_triple}/libbz2.lib CACHE FILEPATH "" FORCE)
	set(LIBGCC_LIBRARY ${BZIP2}/${target_triple}/libgcc.lib CACHE FILEPATH "" FORCE)
endif()


set(TIFF ${DK3RDPARTY_DIR}/tiff-4.0.3 CACHE PATH "" FORCE)
if(EXISTS ${TIFF}/${target_triple}/Release/tiff-static.lib)
	set(TIFF_INCLUDE_DIR ${TIFF}/libtiff CACHE PATH "" FORCE)
	set(TIFF_INCLUDE_DIR2 ${TIFF}/${target_triple} CACHE PATH "" FORCE)
endif()


set(PNG ${DK3RDPARTY_DIR}/libpng-1.7.0beta34 CACHE PATH "" FORCE)
if(EXISTS ${PNG}/${target_triple}/Release/libpng17_static.lib)
	set(PNG_INCLUDE_DIR ${PNG} CACHE PATH "" FORCE)
	set(PNG_INCLUDE_DIR2 ${PNG}/${target_triple} CACHE PATH "" FORCE)
endif()


set(JPEG ${DK3RDPARTY_DIR}/libjpeg-turbo-1.5.3 CACHE PATH "" FORCE)
if(EXISTS ${JPEG}/${target_triple}/Release/turbojpeg-static.lib)
	set(JPEG_INCLUDE_DIR ${JPEG} CACHE PATH "" FORCE)
	set(JPEG_INCLUDE_DIR2 ${JPEG}/${target_triple} CACHE PATH "" FORCE)
endif()


set(GIF ${DK3RDPARTY_DIR}/ CACHE PATH "" FORCE)
if(EXISTS ${GIF}/${target_triple}/Release/lib/.libs/libgif.lib)
	set(GIF_INCLUDE_DIR ${GIF} CACHE PATH "" FORCE)
	set(GIF_INCLUDE_DIR2 ${GIF}/${target_triple} CACHE PATH "" FORCE)
endif()


set(FREETYPE ${DK3RDPARTY_DIR}/freetype-2.5.5 CACHE PATH "" FORCE)
if(EXISTS ${FREETYPE}/${target_triple}/Release/freetype.lib)
	set(FREETYPE_INCLUDE_DIRS ${FREETYPE}/include CACHE PATH "" FORCE)
	set(FREETYPE_INCLUDE_DIR_freetype2 ${FREETYPE}/include CACHE PATH "" FORCE)
	set(FREETYPE_INCLUDE_DIR_ft2build ${FREETYPE}/include CACHE PATH "" FORCE)
	set(FREETYPE_LIBRARY ${FREETYPE}/${target_triple}/Release/freetype.lib CACHE FILEPATH "" FORCE)
	set(FREETYPE_LIBRARY_DEBUG ${FREETYPE}/${target_triple}/Debug/freetype.lib CACHE FILEPATH "" FORCE)
	set(FREETYPE_LIBRARY_RELEASE ${FREETYPE}/${target_triple}/Release/freetype.lib CACHE FILEPATH "" FORCE)
endif()

set(SDL2 ${DK3RDPARTY_DIR}/SDL2-2.0.14 CACHE PATH "" FORCE)
if(EXISTS ${SDL2}/${target_triple}/Release/SDL2.lib)
	set(SDL2_DIR ${SDL2} CACHE PATH "" FORCE)
	set(SDL2_INCLUDE_DIR ${SDL2}/include CACHE PATH "" FORCE)
	set(SDL2_LIBRARY_TEMP ${SDL2}/${target_triple}/Release/SDL2.lib CACHE FILEPATH "" FORCE)
	set(SDL2_LIBRARY ${SDL2}/${target_triple}/Release/SDL2.lib CACHE FILEPATH "" FORCE)
	set(SDL2_LIBRARY_DEBUG ${SDL2}/${target_triple}/Debug/SDL2d.lib CACHE FILEPATH "" FORCE)
	set(SDL2_LIBRARY_RELEASE ${SDL2}/${target_triple}/Release/SDL2.lib CACHE FILEPATH "" FORCE)
	set(SDL2MAIN_LIBRARY_TEMP ${SDL2}/${target_triple}/Release/SDL2main.lib CACHE FILEPATH "" FORCE)
	set(SDL2MAIN_LIBRARY ${SDL2}/${target_triple}/Release/SDL2main.lib CACHE FILEPATH "" FORCE)
	set(SDL2MAIN_LIBRARY_DEBUG ${SDL2}/${target_triple}/Debug/SDL2maind.lib CACHE FILEPATH "" FORCE)
	set(SDL2MAIN_LIBRARY_RELEASE ${SDL2}/${target_triple}/Release/SDL2main.lib CACHE FILEPATH "" FORCE)
endif()


set(SDL2_IMAGE ${DK3RDPARTY_DIR}/SDL2_image-2.0.1 CACHE PATH "" FORCE)
if(EXISTS ${SDL2_IMAGE}/${target_triple}/lib/Release/SDL_image.lib)
	set(SDL2_IMAGE_INCLUDE_DIR ${SDL2_IMAGE} CACHE PATH "" FORCE)
	set(SDL2_IMAGE_LIBRARY_TEMP ${SDL2_IMAGE}/${target_triple}/lib/Release/SDL_image.lib CACHE FILEPATH "" FORCE)
	set(SDL2_IMAGE_LIBRARY ${SDL2_IMAGE}/${target_triple}/lib/Release/SDL_image.lib CACHE FILEPATH "" FORCE)
	set(SDL2_IMAGE_LIBRARY_DEBUG ${SDL2_IMAGE}/${target_triple}/lib/Debug/SDL_image.lib CACHE FILEPATH "" FORCE)
	set(SDL2_IMAGE_LIBRARY_RELEASE ${SDL2_IMAGE}/${target_triple}/lib/Release/SDL_image.lib CACHE FILEPATH "" FORCE)
endif()


set(SFML ${DK3RDPARTY_DIR}/SFML-2.4.2 CACHE PATH "" FORCE)
if(EXISTS ${SFML}/${target_triple}/lib/Release/sfml-main.lib)
	set(SFML_INCLUDE_DIR ${SFML}/include CACHE FILEPATH "" FORCE)
	set(SFML_MAIN_LIBRARY_DEBUG ${SFML}/${target_triple}/lib/Debug/sfml-main-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_MAIN_LIBRARY_RELEASE ${SFML}/${target_triple}/lib/Release/sfml-main.lib CACHE FILEPATH "" FORCE)
	set(SFML_SYSTEM_LIBRARY_DEBUG ${SFML}/${target_triple}/lib/Debug/sfml-system-s-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_SYSTEM_LIBRARY_RELEASE ${SFML}/${target_triple}/lib/Debug/sfml-system-s.lib CACHE FILEPATH "" FORCE)
	set(SFML_WINDOW_LIBRARY_DEBUG ${SFML}/${target_triple}/lib/Debug/sfml-window-s-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_WINDOW_LIBRARY_RELEASE ${SFML}/${target_triple}/lib/Release/sfml-window-s.lib CACHE FILEPATH "" FORCE)
	set(SFML_GRAPHICS_LIBRARY_DEBUG ${SFML}/${target_triple}/lib/Debug/sfml-graphics-s-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_GRAPHICS_LIBRARY_RELEASE ${SFML}/${target_triple}/lib/Release/sfml-graphics-s.lib CACHE FILEPATH "" FORCE)
	set(SFML_AUDIO_LIBRARY_DEBUG ${SFML}/${target_triple}/lib/Debug/sfml-audio-s-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_AUDIO_LIBRARY_RELEASE ${SFML}/${target_triple}/lib/Release/sfml-audio-s.lib CACHE FILEPATH "" FORCE)
endif()

# https://cmake.org/cmake/help/latest/module/FindGLEW.html
set(GLEW ${DK3RDPARTY_DIR}/glew-2.2.0 CACHE PATH "" FORCE)
if(EXISTS ${GLEW}/${target_triple}/lib/Release/libglew32.lib)
	##set(GLEW_DIR ${GLEW}/build/cmake CACHE PATH "" FORCE)
	set(GLEW_USE_STATIC_LIBS ON CACHE BOOL "" FORCE)
	set(GLEW_DIR ${GLEW}/${target_triple}/CMakeFiles/Export/lib/cmake/glew CACHE PATH "" FORCE)
	set(GLEW_LIBRARY ${GLEW}/${target_triple}/lib/Debug/libglew32.lib CACHE FILEPATH "" FORCE)
	set(GLEW_INCLUDE_DIR ${GLEW} CACHE PATH "" FORCE)
	set(GLEW_STATIC_LIBRARY_DEBUG ${GLEW}/${target_triple}/lib/Debug/libglew32d.lib CACHE FILEPATH "" FORCE)
	set(GLEW_STATIC_LIBRARY_RELEASE ${GLEW}/${target_triple}/lib/Release/libglew32.lib CACHE FILEPATH "" FORCE)
	set(GLEW_SHARED_LIBRARY_DEBUG ${GLEW}/${target_triple}/lib/Debug/glew32d.lib CACHE FILEPATH "" FORCE)
	set(GLEW_SHARED_LIBRARY_RELEASE ${GLEW}/${target_triple}/lib/Release/glew32.lib CACHE FILEPATH "" FORCE)
	set(GLEW_LIBRARIES "${GLEW_STATIC_LIBRARY_DEBUG}" CACHE FILEPATH "" FORCE)
	set(GLEW_LIBRARIES ${GLEW_LIBRARIES} "${GLEW_STATIC_LIBRARY_RELEASE}" CACHE FILEPATH "" FORCE)
endif()


set(OPENSSL ${DK3RDPARTY_DIR}/openssl-1.0.2h-vs2015 CACHE PATH "" FORCE)
if(EXISTS ${OPENSSL}/lib/ssleay32MT.lib)
	set(CMAKE_USE_OPENSSL ON CACHE BOOL "" FORCE)
	set(OPENSSL_INCLUDE_DIR ${OPENSSL}/include CACHE PATH "" FORCE)
	set(LIB_EAY_DEBUG ${OPENSSL}/lib/libeay32MTd.lib CACHE FILEPATH "" FORCE)
	set(LIB_EAY_RELEASE ${OPENSSL}/lib/libeay32MT.lib CACHE FILEPATH "" FORCE)
	set(SSL_EAY_DEBUG ${OPENSSL}/lib/ssleay32MTd.lib CACHE FILEPATH "" FORCE)
	set(SSL_EAY_RELEAS ${OPENSSL}/lib/ssleay32MT.lib CACHE FILEPATH "" FORCE)
endif()


set(OPENAL ${DK3RDPARTY_DIR}/openal-1.15.1 CACHE PATH "" FORCE)
if(EXISTS ${OPENAL}/${target_triple}/Release/OpenAL32.lib)
# /I${OPENAL}/include/AL
	set(OPENAL_INCLUDE_DIR ${OPENAL}/include CACHE PATH "" FORCE)
	set(OPENAL_LIB_DIR ${OPENAL}/${target_triple}/Release CACHE PATH "" FORCE)
	set(OPENAL_INCLUDE_DIRS "${OPENAL_INCLUDE_DIR}" CACHE PATH "" FORCE)
	set(OPENAL_INCLUDE_DIRS "${OPENAL_INCLUDE_DIR}" "${OPENAL}/include/AL" CACHE PATH "" FORCE)
endif()


set(VORBIS ${DK3RDPARTY_DIR}/libvorbis-1.3.5 CACHE PATH "" FORCE)
if(EXISTS ${VORBIS}/${target_triple}/Release/lib/.libs/libvorbis.lib)
	set(VORBIS_INCLUDE_DIR ${VORBIS}/include CACHE PATH "" FORCE)
endif()


set(OGG ${DK3RDPARTY_DIR}/libogg-1.3.2 CACHE PATH "" FORCE)
if(EXISTS ${OGG}/${target_triple}/Release/src/.libs/libogg.lib)
	set(OGG_INCLUDE_DIR ${OGG}/include CACHE PATH "" FORCE)
endif()


set(SMPEG2 ${DK3RDPARTY_DIR}/smpeg2-2.0.0 CACHE PATH "" FORCE)
if(EXISTS ${SMPEG2}/${target_triple}/lib/Release/libsmpeg2.lib)
	set(SMPEG_INCLUDE_DIR ${SMPEG2} CACHE PATH "" FORCE)
endif()



