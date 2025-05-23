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
set(SDLIMAGE_SUPPORT_SVG ON CACHE BOOL "Support for SVG file format")
set(SDLIMAGE_SUPPORT_TGA ON CACHE BOOL "Support for TGA file format")
set(SDLIMAGE_SUPPORT_XPM ON CACHE BOOL "Support for XPM file format")
set(SDLIMAGE_SUPPORT_XV ON CACHE BOOL "Support for XV file format")
#set(SDLIMAGE_SUPPORT_JPEG OFF CACHE BOOL "Support for JPEG file format")
#set(SDLIMAGE_SUPPORT_PNG OFF CACHE BOOL "Support for PNG file format")
#set(SDLIMAGE_SUPPORT_WEBP OFF CACHE BOOL "Support for WEBP file format")
#set(SDLIMAGE_SUPPORT_TIFF OFF CACHE BOOL "Support for TIFF file format")

##ADDED BY DigitalKnob
	IF(SDLIMAGE_SUPPORT_BMP)
		add_definitions(-DLOAD_BMP)
	ENDIF()
	IF(SDLIMAGE_SUPPORT_LBM)
		add_definitions(-DLOAD_LBM)
	ENDIF()
	IF(SDLIMAGE_SUPPORT_PCX)
		add_definitions(-DLOAD_PCX)
	ENDIF()
	IF(SDLIMAGE_SUPPORT_PNM)
		add_definitions(-DLOAD_PNM)
	ENDIF()
	IF(SDLIMAGE_SUPPORT_SVG)
		add_definitions(-DLOAD_SVG)
	ENDIF()
	IF(SDLIMAGE_SUPPORT_TGA)
		add_definitions(-DLOAD_TGA)
	ENDIF()
	IF(SDLIMAGE_SUPPORT_QOI)
		add_definitions(-DLOAD_QOI)
	ENDIF()
	IF(SDLIMAGE_SUPPORT_XCF)
		add_definitions(-DLOAD_XCF)
	ENDIF()
	IF(SDLIMAGE_SUPPORT_XPM)
		add_definitions(-DLOAD_XPM)
	ENDIF()
	IF(SDLIMAGE_SUPPORT_XV)
		add_definitions(-DLOAD_XV)
	ENDIF()
	IF(WEBP_INCLUDE_DIR)
		add_definitions(-DLOAD_WEBP)
		include_directories(${WEBP_INCLUDE_DIR})
	ENDIF()
	IF(TIFF_INCLUDE_DIR)
		#set(SDLIMAGE_SUPPORT_TIFF ON)
		add_definitions(-DLOAD_TIF)
		include_directories(${TIFF_INCLUDE_DIR})
	ENDIF()
	IF(TIFF_INCLUDE_DIR2)
		include_directories(${TIFF_INCLUDE_DIR2})
	ENDIF()
	IF(PNG_INCLUDE_DIR)
		#set(SDLIMAGE_SUPPORT_PNG ON)
		add_definitions(-DLOAD_PNG)
		include_directories(${PNG_INCLUDE_DIR})
	ENDIF()
	IF(PNG_INCLUDE_DIR2)
		include_directories(${PNG_INCLUDE_DIR2})
	ENDIF()
	IF(JPEG_INCLUDE_DIR)
		#set(SDLIMAGE_SUPPORT_JPEG ON)
		add_definitions(-DLOAD_JPG)
		include_directories(${JPEG_INCLUDE_DIR})
	ENDIF()
	IF(JPEG_INCLUDE_DIR2)
		include_directories(${JPEG_INCLUDE_DIR2})
	ENDIF()
	IF(GIF_INCLUDE_DIR)
		#set(SDLIMAGE_SUPPORT_GIF ON)
		add_definitions(-DLOAD_GIF)
		include_directories(${GIF_INCLUDE_DIR})
	ENDIF()
	IF(GIF_INCLUDE_DIR2)
		include_directories(${GIF_INCLUDE_DIR2})
	ENDIF()
	IF(ZLIB_INCLUDE_DIR)
		include_directories(${ZLILB_INCLUDE_DIR})
	ENDIF()
##ADDED BY DigitalKnob
	
		
set(SDLIMAGE_SRC
	IMG.c
	IMG_avif.c
	IMG_bmp.c
	IMG_gif.c
	IMG_jpg.c
	IMG_jxl.c
	IMG_lbm.c
	IMG_pcx.c
	IMG_png.c
	IMG_pnm.c
	IMG_qoi.c
	IMG_svg.c
	IMG_tga.c
	IMG_tif.c
	IMG_webp.c
	IMG_WIC.c
	IMG_xcf.c
	IMG_xpm.c
	IMG_xv.c
	IMG_xxx.c
)

if(CMAKE_HOST_APPLE)
	list(APPEND SDLIMAGE_SRC IMG_ImageIO.m)
endif()

#set(SDLIMAGE_SOURCES ${SDLIMAGE_SRC})

include_directories(./)

add_library(SDLIMAGE STATIC ${SDLIMAGE_SRC})
set_target_properties(SDLIMAGE PROPERTIES 
	ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)
target_link_libraries(SDLIMAGE ${SDL2_LIBRARIES})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY build)
set_target_properties(SDLIMAGE PROPERTIES PREFIX "" OUTPUT_NAME "SDL_image")
