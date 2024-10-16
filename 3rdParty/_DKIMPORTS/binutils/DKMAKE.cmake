#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
# binutils


dk_load(dk_builder)


# https://wiki.termux.com/wiki/ASM
if(ANDROID_HOST)
	#dk_command(pkg install binutils)
	dk_installPackage(binutils)
endif()