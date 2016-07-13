cmake_minimum_required (VERSION 3.0.2)
project (SDLIMAGE)

list(APPEND CMAKE_MODULE_PATH "${SDLIMAGE_SOURCE_DIR}/cmake")

include(CheckLibraryExists)
include(CheckIncludeFiles)
include(CheckIncludeFile)

find_package(SDL2 REQUIRED)

set(SDL2_LIBRARIES "${SDL2_LIBRARY}")
set(SDL2_INCLUDE_DIRS "${SDL2_INCLUDE_DIR}")

include_directories(${SDL2_INCLUDE_DIRS})

set(SDLIMAGE_SUPPORT_BMP ON CACHE BOOL "Support for BMP file format")
set(SDLIMAGE_SUPPORT_GIF ON CACHE BOOL "Support for GIF file format")
set(SDLIMAGE_SUPPORT_LBM ON CACHE BOOL "Support for LBM file format")
set(SDLIMAGE_SUPPORT_PCX ON CACHE BOOL "Support for PCX file format")
set(SDLIMAGE_SUPPORT_PNM ON CACHE BOOL "Support for PNM file format")
set(SDLIMAGE_SUPPORT_TGA ON CACHE BOOL "Support for TGA file format")
set(SDLIMAGE_SUPPORT_XPM ON CACHE BOOL "Support for XPM file format")
set(SDLIMAGE_SUPPORT_XV ON CACHE BOOL "Support for XV file format")

set(SDLIMAGE_SUPPORT_JPEG ON CACHE BOOL "Support for JPEG file format")
set(SDLIMAGE_SUPPORT_PNG ON CACHE BOOL "Support for PNG file format")
set(SDLIMAGE_SUPPORT_WEBP ON CACHE BOOL "Support for WEBP file format")
set(SDLIMAGE_SUPPORT_TIFF ON CACHE BOOL "Support for TIFF file format")

if(SDLIMAGE_SUPPORT_BMP)
	add_definitions(-DLOAD_BMP)
endif()
if(SDLIMAGE_SUPPORT_GIF)
	add_definitions(-DLOAD_GIF)
	INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../giflib-5.1.1")
	IF(WIN_32)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../giflib-5.1.1/win32")
	ENDIF()
	IF(WIN_64)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../giflib-5.1.1/win64")
	ENDIF()
	IF(MAC_64)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../giflib-5.1.1/mac64")
	ENDIF()
	IF(IOSSIM_32)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../giflib-5.1.1/iossim32/Release-iphonesimulator")
	ENDIF()
	IF(LINUX_64)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../giflib-5.1.1/linux64")
	ENDIF()
endif()
if(SDLIMAGE_SUPPORT_LBM)
	add_definitions(-DLOAD_LBM)
endif()
if(SDLIMAGE_SUPPORT_PCX)
	add_definitions(-DLOAD_PCX)
endif()
if(SDLIMAGE_SUPPORT_PNM)
	add_definitions(-DLOAD_PNM)
endif()
if(SDLIMAGE_SUPPORT_TGA)
IF(NOT APPLE)
	add_definitions(-DLOAD_TGA)
ENDIF()	
endif()
if(SDLIMAGE_SUPPORT_XPM)
	add_definitions(-DLOAD_XPM)
endif()
if(SDLIMAGE_SUPPORT_XV)
	add_definitions(-DLOAD_XV)
endif()

IF(NOT LINUX)
if(SDLIMAGE_SUPPORT_JPEG)
	add_definitions(-DLOAD_JPG)
	INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../jpeg-6b")
	IF(WIN_32)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../jpeg-6b/win32")
	ENDIF()
	IF(WIN_64)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../jpeg-6b/win64")
	ENDIF()
	IF(MAC_64)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../jpeg-6b/mac64")
	ENDIF()
	IF(IOSSIM_32)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../jpeg-6b/iossim32")
	ENDIF()
	IF(LINUX_64)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../jpeg-6b/linux64/Release")
	ENDIF()
endif()
ENDIF()

if(SDLIMAGE_SUPPORT_PNG)
	add_definitions(-DLOAD_PNG)
	INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../libpng-1.7.0beta34")
	IF(WIN_32)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../libpng-1.7.0beta34/win32")
	ENDIF()
	IF(WIN_64)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../libpng-1.7.0beta34/win64")
	ENDIF()
	IF(MAC_64)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../libpng-1.7.0beta34/mac64")
	ENDIF()
	IF(IOSSIM_32)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../libpng-1.7.0beta34/iossim32")
	ENDIF()
	IF(LINUX_64)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../libpng-1.7.0beta34/linux64/Release")
	ENDIF()
endif()

if(SDLIMAGE_SUPPORT_TIFF)
	add_definitions(-DLOAD_TIF)
	INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../tiff-4.0.3")
	INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../tiff-4.0.3/libtiff")
	IF(WIN_32)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../tiff-4.0.3/win32")
	ENDIF(WIN_32)
	IF(WIN_64)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../tiff-4.0.3/win64")
	ENDIF()
	IF(MAC_64)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../tiff-4.0.3/mac64")
	ENDIF()
	IF(IOSSIM_32)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../tiff-4.0.3/iossim32")
	ENDIF()
	IF(LINUX_64)
		INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../tiff-4.0.3/linux64/Release")
	ENDIF()
endif()

if(SDLIMAGE_SUPPORT_WEBP)
	add_definitions(-DLOAD_WEBP)
endif()

set(SDLIMAGE_SRC
	IMG.c
	IMG_bmp.c
	IMG_gif.c
	IMG_jpg.c
	IMG_lbm.c
	IMG_pcx.c
	IMG_png.c
	IMG_pnm.c
	IMG_tga.c
	IMG_tif.c
	IMG_webp.c
	IMG_xcf.c
	IMG_xpm.c
	IMG_xv.c
	IMG_xxx.c
)

set(SDLIMAGE_SOURCES
	${SDLIMAGE_SRC}
)

include_directories(./)

add_library(SDLIMAGE STATIC
	${SDLIMAGE_SOURCES}
)

#add_dependencies(SDLIMAGE SDL2)

set_target_properties(SDLIMAGE
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

target_link_libraries (SDLIMAGE
	${SDL2_LIBRARIES}
)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY build)
set_target_properties(SDLIMAGE PROPERTIES
	PREFIX ""
	OUTPUT_NAME "SDL_image"
)
