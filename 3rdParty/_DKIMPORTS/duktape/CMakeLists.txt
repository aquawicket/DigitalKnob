# CMake for duktape
cmake_minimum_required(VERSION 3.10)

project(duktape)

include_directories(C:/Users/Administrator/digitalknob/DK/3rdParty/duktape-master/dist/src)

file(GLOB duktape_SRC C:/Users/Administrator/digitalknob/DK/3rdParty/duktape-master/dist/src/*.c)

add_library(duktape STATIC ${duktape_SRC})
