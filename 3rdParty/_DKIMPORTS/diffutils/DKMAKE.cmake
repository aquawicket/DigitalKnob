#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
# https://packages.msys2.org/base/diffutils

dk_load(dk_builder)

if(MSYSTEM)
	dk_depend(msys2)
	
	dk_installPackage(diffutils)
endif()