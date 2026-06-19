#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ lzo ############
# Portable lossless data compression library
# https://www.oberhumer.com/opensource/lzo
# https://packages.msys2.org/base/lzo2
# https://github.com/eyeseaevan/lzo-2.10.git
# https://github.com/eyeseaevan/lzo-2.10.git

dk_import()

dk_include("${lzo}/include"		LZO2_INCLUDE_DIR)	
# TODO

dk_set(lzo_CMAKE
	-DLZO2_LIBRARY=${LZO2_LIBRARY}
	-DLZO2_INCLUDE_DIR=${LZO2_INCLUDE_DIR})


