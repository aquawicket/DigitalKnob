#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://packages.msys2.org/base/gdb


if(DEFINED ENV{MSYSTEM})
	dk_set(MSYSTEM "$ENV{MSYSTEM}")
	dk_set($ENV{MSYSTEM} 1)
endif()


#dk_depend(msys2)

dk_installPackage(gdb)
