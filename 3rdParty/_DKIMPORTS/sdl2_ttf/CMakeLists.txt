cmake_minimum_required (VERSION 3.1.0)
project (SDLTTF)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(CheckLibraryExists)
include(CheckIncludeFiles)
include(CheckIncludeFile)

find_package(SDL2 REQUIRED)

set(SDL2_LIBRARIES "${SDL2_LIBRARY}")
set(SDL2_INCLUDE_DIRS "${SDL2_INCLUDE_DIR}")

include_directories(${SDL2_INCLUDE_DIRS})


find_package(FREETYPE REQUIRED)

include_directories(${FREETYPE_INCLUDE_DIRS})
include_directories(${FREETYPE_INCLUDE_DIR_freetype2})
include_directories(${FREETYPE_INCLUDE_DIR_ft2build})

#INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../freetype-2.5.5/include")
#IF(WIN_32)
#	INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../freetype-2.5.5/win32")
#ENDIF()
#IF(WIN_64)
#	INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../freetype-2.5.5/win64")
#ENDIF()
#IF(MAC_64)
#	INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../freetype-2.5.5/mac64")
#ENDIF()
#IF(IOSSIM_32)
#	INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../freetype-2.5.5/iossim32")
#ENDIF()
#IF(LINUX_64)
#	INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/../freetype-2.5.5/linux64/Release")
#ENDIF()


set(SDLTTF_SRC
	SDL_ttf.c
)

set(SDLTTF_SOURCES
	${SDLTTF_SRC}
)

include_directories(./)

add_library(SDLTTF STATIC
	${SDLTTF_SOURCES}
)

set_target_properties(SDLTTF
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

target_link_libraries (SDLTTF
	${SDL2_LIBRARIES}
)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY build)
set_target_properties(SDLTTF PROPERTIES
	PREFIX ""
	OUTPUT_NAME "SDL_ttf"
)
