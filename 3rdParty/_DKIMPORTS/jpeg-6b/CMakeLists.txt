cmake_minimum_required(VERSION 2.8)

project(jpeg)

include(CheckIncludeFiles)

FILE(GLOB JPEG_SRC 
*.c
)

## FIMXE - these aren't working
list(REMOVE_ITEM JPEG_SRC ${CMAKE_CURRENT_SOURCE_DIR}/jmemmac.c)
list(REMOVE_ITEM JPEG_SRC ${CMAKE_CURRENT_SOURCE_DIR}/jmemdos.c)
list(REMOVE_ITEM JPEG_SRC ${CMAKE_CURRENT_SOURCE_DIR}/ansi2knr.c)
list(REMOVE_ITEM JPEG_SRC ${CMAKE_CURRENT_SOURCE_DIR}/jpegtran.c)
list(REMOVE_ITEM JPEG_SRC ${CMAKE_CURRENT_SOURCE_DIR}/djpeg.c)
list(REMOVE_ITEM JPEG_SRC ${CMAKE_CURRENT_SOURCE_DIR}/wrjpgcom.c)
list(REMOVE_ITEM JPEG_SRC ${CMAKE_CURRENT_SOURCE_DIR}/ckconfig.c)
list(REMOVE_ITEM JPEG_SRC ${CMAKE_CURRENT_SOURCE_DIR}/cjpeg.c)
list(REMOVE_ITEM JPEG_SRC ${CMAKE_CURRENT_SOURCE_DIR}/rdjpgcom.c)
list(REMOVE_ITEM JPEG_SRC ${CMAKE_CURRENT_SOURCE_DIR}/example.c)

if(MSVC)
	file(COPY jconfig.vc DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
	file(RENAME ${CMAKE_CURRENT_BINARY_DIR}/jconfig.vc ${CMAKE_CURRENT_BINARY_DIR}/jconfig.h)
else()
	check_include_files("stddef.h" HAVE_STDDEF_H)
	check_include_files("stdlib.h" HAVE_STDLIB_H)
	check_include_files("locale.h" HAVE_LOCALE_H)
	configure_file(jconfig.cmake jconfig.h)
endif()

add_library(jpeg-static STATIC ${JPEG_SRC})
target_include_directories(jpeg-static PUBLIC . ${CMAKE_CURRENT_BINARY_DIR})