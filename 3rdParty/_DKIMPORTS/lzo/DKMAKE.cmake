#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# Portable lossless data compression library
# 
# https://www.oberhumer.com/opensource/lzo
# https://packages.msys2.org/base/lzo2
# https://github.com/eyeseaevan/lzo-2.10.git
# https://github.com/eyeseaevan/lzo-2.10.git


dk_import(https://github.com/SyntaxSnack/lzo-2.10/archive/f289550313cd59695f238990846cd7f9cefed8cd.zip)
#dk_import(https://github.com/SyntaxSnack/lzo-2.10/archive/refs/heads/master.zip)
