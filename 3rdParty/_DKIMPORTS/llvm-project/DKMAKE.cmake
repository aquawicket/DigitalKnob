#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


# https://github.com/llvm/llvm-project

dk_import(https://github.com/llvm/llvm-project/archive/d50d9613e33274146d9bccfd09e4e8d7654f7e4a.zip)