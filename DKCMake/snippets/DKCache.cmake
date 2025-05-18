## https://stackoverflow.com/a/31044116/688352

## USAGE:  Place this cmake command into the command line for any DKINSTALL.cmake build scripts using any of these these libraries
##	-C$ENV{DKCMAKE_DIR}/DKCache.cmake
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

#project(HelloWorld C CXX)
##set(OS Windows_X86 CACHE PATH "" FORCE)
set(DK3RDPARTY_DIR "C:/Users/$ENV{USERNAME}/digitalknob/Development/3rdParty" CACHE PATH "" FORCE)

##${STDINT}

set(ZLIB $ENV{DK3RDPARTY_DIR}/zlib-1.2.11 CACHE PATH "" FORCE)
if(EXISTS ${ZLIB}/${Target_Tuple}/Release/zlibstatic.lib)
	set(ZLIB_INCLUDE_DIR ${ZLIB} CACHE PATH "" FORCE)
	set(ZLIB_LIBRARY ${ZLIB}/${Target_Tuple}/Release/zlibstatic.lib CACHE FILEPATH "" FORCE)
	set(ZLIB_LIBRARY_DEBUG ${ZLIB}/${Target_Tuple}/Debug/zlibstatic.lib CACHE FILEPATH "" FORCE)
	set(ZLIB_LIBRARY_RELEASE ${ZLIB}/${Target_Tuple}/Release/zlibstatic.lib CACHE FILEPATH "" FORCE)
endif()

#execute_process(COMMAND ${CMD_EXE} /c set /p DUMMY=Hit ENTER to continue... WORKING_DIRECTORY C:/)

set(BZIP2 $ENV{DK3RDPARTY_DIR}/bzip2-1.0.6 CACHE PATH "" FORCE)
if(EXISTS ${BZIP2}/${Target_Tuple}/libbz2.lib)
	set(BZIP2_ROOT ${BZIP2} CACHE PATH "" FORCE)
	set(BZIP2_INCLUDE_DIR ${BZIP2} CACHE PATH "" FORCE)
	set(BZIP2_LIBRARY ${BZIP2}/${Target_Tuple}/libbz2.lib CACHE FILEPATH "" FORCE)
	set(BZIP2_LIBRARY_DEBUG ${BZIP2}/${Target_Tuple}/libbz2.lib CACHE FILEPATH "" FORCE)
	set(BZIP2_LIBRARY_RELEASE ${BZIP2}/${Target_Tuple}/libbz2.lib CACHE FILEPATH "" FORCE)
	set(LIBGCC_LIBRARY ${BZIP2}/${Target_Tuple}/libgcc.lib CACHE FILEPATH "" FORCE)
endif()


set(TIFF $ENV{DK3RDPARTY_DIR}/tiff-4.0.3 CACHE PATH "" FORCE)
if(EXISTS ${TIFF}/${Target_Tuple}/Release/tiff-static.lib)
	set(TIFF_INCLUDE_DIR ${TIFF}/libtiff CACHE PATH "" FORCE)
	set(TIFF_INCLUDE_DIR2 ${TIFF}/${Target_Tuple} CACHE PATH "" FORCE)
endif()


set(PNG $ENV{DK3RDPARTY_DIR}/libpng-1.7.0beta34 CACHE PATH "" FORCE)
if(EXISTS ${PNG}/${Target_Tuple}/Release/libpng17_static.lib)
	set(PNG_INCLUDE_DIR ${PNG} CACHE PATH "" FORCE)
	set(PNG_INCLUDE_DIR2 ${PNG}/${Target_Tuple} CACHE PATH "" FORCE)
endif()


set(JPEG $ENV{DK3RDPARTY_DIR}/libjpeg-turbo-1.5.3 CACHE PATH "" FORCE)
if(EXISTS ${JPEG}/${Target_Tuple}/Release/turbojpeg-static.lib)
	set(JPEG_INCLUDE_DIR ${JPEG} CACHE PATH "" FORCE)
	set(JPEG_INCLUDE_DIR2 ${JPEG}/${Target_Tuple} CACHE PATH "" FORCE)
endif()


set(GIF $ENV{DK3RDPARTY_DIR}/ CACHE PATH "" FORCE)
if(EXISTS ${GIF}/${Target_Tuple}/Release/lib/.libs/libgif.lib)
	set(GIF_INCLUDE_DIR ${GIF} CACHE PATH "" FORCE)
	set(GIF_INCLUDE_DIR2 ${GIF}/${Target_Tuple} CACHE PATH "" FORCE)
endif()


set(FREETYPE $ENV{DK3RDPARTY_DIR}/freetype-2.5.5 CACHE PATH "" FORCE)
if(EXISTS ${FREETYPE}/${Target_Tuple}/Release/freetype.lib)
	set(FREETYPE_INCLUDE_DIRS ${FREETYPE}/include CACHE PATH "" FORCE)
	set(FREETYPE_INCLUDE_DIR_freetype2 ${FREETYPE}/include CACHE PATH "" FORCE)
	set(FREETYPE_INCLUDE_DIR_ft2build ${FREETYPE}/include CACHE PATH "" FORCE)
	set(FREETYPE_LIBRARY ${FREETYPE}/${Target_Tuple}/Release/freetype.lib CACHE FILEPATH "" FORCE)
	set(FREETYPE_LIBRARY_DEBUG ${FREETYPE}/${Target_Tuple}/Debug/freetype.lib CACHE FILEPATH "" FORCE)
	set(FREETYPE_LIBRARY_RELEASE ${FREETYPE}/${Target_Tuple}/Release/freetype.lib CACHE FILEPATH "" FORCE)
endif()

set(SDL2 $ENV{DK3RDPARTY_DIR}/SDL2-2.0.14 CACHE PATH "" FORCE)
if(EXISTS ${SDL2}/${Target_Tuple}/Release/SDL2.lib)
	set(SDL2_DIR ${SDL2} CACHE PATH "" FORCE)
	set(SDL2_INCLUDE_DIR ${SDL2}/include CACHE PATH "" FORCE)
	set(SDL2_LIBRARY_TEMP ${SDL2}/${Target_Tuple}/Release/SDL2.lib CACHE FILEPATH "" FORCE)
	set(SDL2_LIBRARY ${SDL2}/${Target_Tuple}/Release/SDL2.lib CACHE FILEPATH "" FORCE)
	set(SDL2_LIBRARY_DEBUG ${SDL2}/${Target_Tuple}/Debug/SDL2d.lib CACHE FILEPATH "" FORCE)
	set(SDL2_LIBRARY_RELEASE ${SDL2}/${Target_Tuple}/Release/SDL2.lib CACHE FILEPATH "" FORCE)
	set(SDL2MAIN_LIBRARY_TEMP ${SDL2}/${Target_Tuple}/Release/SDL2main.lib CACHE FILEPATH "" FORCE)
	set(SDL2MAIN_LIBRARY ${SDL2}/${Target_Tuple}/Release/SDL2main.lib CACHE FILEPATH "" FORCE)
	set(SDL2MAIN_LIBRARY_DEBUG ${SDL2}/${Target_Tuple}/Debug/SDL2maind.lib CACHE FILEPATH "" FORCE)
	set(SDL2MAIN_LIBRARY_RELEASE ${SDL2}/${Target_Tuple}/Release/SDL2main.lib CACHE FILEPATH "" FORCE)
endif()


set(SDL2_IMAGE $ENV{DK3RDPARTY_DIR}/SDL2_image-2.0.1 CACHE PATH "" FORCE)
if(EXISTS ${SDL2_IMAGE}/${Target_Tuple}/lib/Release/SDL_image.lib)
	set(SDL2_IMAGE_INCLUDE_DIR ${SDL2_IMAGE} CACHE PATH "" FORCE)
	set(SDL2_IMAGE_LIBRARY_TEMP ${SDL2_IMAGE}/${Target_Tuple}/lib/Release/SDL_image.lib CACHE FILEPATH "" FORCE)
	set(SDL2_IMAGE_LIBRARY ${SDL2_IMAGE}/${Target_Tuple}/lib/Release/SDL_image.lib CACHE FILEPATH "" FORCE)
	set(SDL2_IMAGE_LIBRARY_DEBUG ${SDL2_IMAGE}/${Target_Tuple}/lib/Debug/SDL_image.lib CACHE FILEPATH "" FORCE)
	set(SDL2_IMAGE_LIBRARY_RELEASE ${SDL2_IMAGE}/${Target_Tuple}/lib/Release/SDL_image.lib CACHE FILEPATH "" FORCE)
endif()


set(SFML $ENV{DK3RDPARTY_DIR}/SFML-2.4.2 CACHE PATH "" FORCE)
if(EXISTS ${SFML}/${Target_Tuple}/lib/Release/sfml-main.lib)
	set(SFML_INCLUDE_DIR ${SFML}/include CACHE FILEPATH "" FORCE)
	set(SFML_MAIN_LIBRARY_DEBUG ${SFML}/${Target_Tuple}/lib/Debug/sfml-main-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_MAIN_LIBRARY_RELEASE ${SFML}/${Target_Tuple}/lib/Release/sfml-main.lib CACHE FILEPATH "" FORCE)
	set(SFML_SYSTEM_LIBRARY_DEBUG ${SFML}/${Target_Tuple}/lib/Debug/sfml-system-s-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_SYSTEM_LIBRARY_RELEASE ${SFML}/${Target_Tuple}/lib/Debug/sfml-system-s.lib CACHE FILEPATH "" FORCE)
	set(SFML_WINDOW_LIBRARY_DEBUG ${SFML}/${Target_Tuple}/lib/Debug/sfml-window-s-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_WINDOW_LIBRARY_RELEASE ${SFML}/${Target_Tuple}/lib/Release/sfml-window-s.lib CACHE FILEPATH "" FORCE)
	set(SFML_GRAPHICS_LIBRARY_DEBUG ${SFML}/${Target_Tuple}/lib/Debug/sfml-graphics-s-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_GRAPHICS_LIBRARY_RELEASE ${SFML}/${Target_Tuple}/lib/Release/sfml-graphics-s.lib CACHE FILEPATH "" FORCE)
	set(SFML_AUDIO_LIBRARY_DEBUG ${SFML}/${Target_Tuple}/lib/Debug/sfml-audio-s-d.lib CACHE FILEPATH "" FORCE)
	set(SFML_AUDIO_LIBRARY_RELEASE ${SFML}/${Target_Tuple}/lib/Release/sfml-audio-s.lib CACHE FILEPATH "" FORCE)
endif()

# https://cmake.org/cmake/help/latest/module/FindGLEW.html
set(GLEW $ENV{DK3RDPARTY_DIR}/glew-2.2.0 CACHE PATH "" FORCE)
if(EXISTS ${GLEW}/${Target_Tuple}/lib/Release/libglew32.lib)
	##set(GLEW_DIR ${GLEW}/build/cmake CACHE PATH "" FORCE)
	set(GLEW_USE_STATIC_LIBS ON CACHE BOOL "" FORCE)
	set(GLEW_DIR ${GLEW}/${Target_Tuple}/CMakeFiles/Export/lib/cmake/glew CACHE PATH "" FORCE)
	set(GLEW_LIBRARY ${GLEW}/${Target_Tuple}/lib/Debug/libglew32.lib CACHE FILEPATH "" FORCE)
	set(GLEW_INCLUDE_DIR ${GLEW} CACHE PATH "" FORCE)
	set(GLEW_STATIC_LIBRARY_DEBUG ${GLEW}/${Target_Tuple}/lib/Debug/libglew32d.lib CACHE FILEPATH "" FORCE)
	set(GLEW_STATIC_LIBRARY_RELEASE ${GLEW}/${Target_Tuple}/lib/Release/libglew32.lib CACHE FILEPATH "" FORCE)
	set(GLEW_SHARED_LIBRARY_DEBUG ${GLEW}/${Target_Tuple}/lib/Debug/glew32d.lib CACHE FILEPATH "" FORCE)
	set(GLEW_SHARED_LIBRARY_RELEASE ${GLEW}/${Target_Tuple}/lib/Release/glew32.lib CACHE FILEPATH "" FORCE)
	set(GLEW_LIBRARIES "${GLEW_STATIC_LIBRARY_DEBUG}" CACHE FILEPATH "" FORCE)
	set(GLEW_LIBRARIES ${GLEW_LIBRARIES} "${GLEW_STATIC_LIBRARY_RELEASE}" CACHE FILEPATH "" FORCE)
endif()


set(OPENSSL $ENV{DK3RDPARTY_DIR}/openssl-1.0.2h-vs2015 CACHE PATH "" FORCE)
if(EXISTS ${OPENSSL}/lib/ssleay32MT.lib)
	set(CMAKE_USE_OPENSSL ON CACHE BOOL "" FORCE)
	set(OPENSSL_INCLUDE_DIR ${OPENSSL}/include CACHE PATH "" FORCE)
	set(LIB_EAY_DEBUG ${OPENSSL}/lib/libeay32MTd.lib CACHE FILEPATH "" FORCE)
	set(LIB_EAY_RELEASE ${OPENSSL}/lib/libeay32MT.lib CACHE FILEPATH "" FORCE)
	set(SSL_EAY_DEBUG ${OPENSSL}/lib/ssleay32MTd.lib CACHE FILEPATH "" FORCE)
	set(SSL_EAY_RELEAS ${OPENSSL}/lib/ssleay32MT.lib CACHE FILEPATH "" FORCE)
endif()


set(OPENAL $ENV{DK3RDPARTY_DIR}/openal-1.15.1 CACHE PATH "" FORCE)
if(EXISTS ${OPENAL}/${Target_Tuple}/Release/OpenAL32.lib)
# /I${OPENAL}/include/AL
	set(OPENAL_INCLUDE_DIR ${OPENAL}/include CACHE PATH "" FORCE)
	set(OPENAL_LIB_DIR ${OPENAL}/${Target_Tuple}/Release CACHE PATH "" FORCE)
	set(OPENAL_INCLUDE_DIRS "${OPENAL_INCLUDE_DIR}" CACHE PATH "" FORCE)
	set(OPENAL_INCLUDE_DIRS "${OPENAL_INCLUDE_DIR}" "${OPENAL}/include/AL" CACHE PATH "" FORCE)
endif()


set(VORBIS $ENV{DK3RDPARTY_DIR}/libvorbis-1.3.5 CACHE PATH "" FORCE)
if(EXISTS ${VORBIS}/${Target_Tuple}/Release/lib/.libs/libvorbis.lib)
	set(VORBIS_INCLUDE_DIR ${VORBIS}/include CACHE PATH "" FORCE)
endif()


set(OGG $ENV{DK3RDPARTY_DIR}/libogg-1.3.2 CACHE PATH "" FORCE)
if(EXISTS ${OGG}/${Target_Tuple}/Release/src/.libs/libogg.lib)
	set(OGG_INCLUDE_DIR ${OGG}/include CACHE PATH "" FORCE)
endif()


set(SMPEG2 $ENV{DK3RDPARTY_DIR}/smpeg2-2.0.0 CACHE PATH "" FORCE)
if(EXISTS ${SMPEG2}/${Target_Tuple}/lib/Release/libsmpeg2.lib)
	set(SMPEG_INCLUDE_DIR ${SMPEG2} CACHE PATH "" FORCE)
endif()



