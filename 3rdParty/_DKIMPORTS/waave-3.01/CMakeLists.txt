cmake_minimum_required (VERSION 3.0.2)
project(waave)

FILE(GLOB waave_SRC 
	src/*.h
	src/*.c)

add_definitions("-DHAVE_CONFIG_H")

include_directories(${FFMPEG_INCLUDE_DIR})
include_directories(${SDL2_INCLUDE_DIR})
add_library(waave STATIC ${waave_SRC})
