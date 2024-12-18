#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ binutils ############
dk_load(dk_builder)

if(ANDROID_HOST)
	# https://wiki.termux.com/wiki/ASM
	dk_installPackage(binutils)
endif()
