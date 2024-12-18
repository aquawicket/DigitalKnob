#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ lzo ############
# Portable lossless data compression library
# https://www.oberhumer.com/opensource/lzo
# https://packages.msys2.org/base/lzo2
# https://github.com/eyeseaevan/lzo-2.10.git
# https://github.com/eyeseaevan/lzo-2.10.git
dk_load(dk_builder)

dk_import(https://github.com/SyntaxSnack/lzo-2.10/archive/f2895503.zip)
