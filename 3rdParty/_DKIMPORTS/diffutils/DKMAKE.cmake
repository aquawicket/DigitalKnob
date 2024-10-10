#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://packages.msys2.org/base/diffutils

if(MSYSTEM)
	dk_depend(msys2)
	
	dk_installPackage(diffutils)
endif()