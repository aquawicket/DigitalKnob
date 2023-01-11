# CMake for duktape
cmake_minimum_required(VERSION 3.10)

project(duktape)

#include_directories(${CMAKE_SOURCE_DIR}/dist/src)
#file(GLOB duktape_SRC ${CMAKE_SOURCE_DIR}/dist/src/*.c)
include_directories(${CMAKE_SOURCE_DIR}/src)
file(GLOB duktape_SRC ${CMAKE_SOURCE_DIR}/src/*.c)

add_library(duktape STATIC ${duktape_SRC})
