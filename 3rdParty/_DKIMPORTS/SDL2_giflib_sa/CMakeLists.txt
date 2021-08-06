cmake_minimum_required (VERSION 3.0.2)
project(SDL2_gif)

FILE(GLOB SDL2_gif_SRC 
	*.h
	*.c)

include_directories(${SDL2_INCLUDE_DIR})
add_library(SDL2_gif STATIC ${SDL2_gif_SRC})
