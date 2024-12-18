#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ yasm ############
# https://packages.msys2.org/base/yasm

dk_load(dk_builder)

if(MSYSTEM)
	dk_depend(msys2)
	
	dk_installPackage(yasm)
endif()
