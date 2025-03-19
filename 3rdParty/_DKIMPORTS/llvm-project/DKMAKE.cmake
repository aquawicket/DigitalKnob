#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ llvm-project ############
# https://github.com/llvm/llvm-project

dk_import(https://github.com/llvm/llvm-project/archive/d50d9613.zip)