# CMake for stackwalker
cmake_minimum_required(VERSION 3.10)

project(stackwalker)

include_directories(${CMAKE_SOURCE_DIR}/StackWalker)
file(GLOB stackwalker_SRC ${CMAKE_SOURCE_DIR}/StackWalker/StackWalker.cpp)
add_library(stackwalker STATIC ${stackwalker_SRC})
