#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ ios-cmake ############
# https://github.com/leetal/ios-cmake
# https://github.com/leetal/ios-cmake/archive/ad96a372.zip

dk_import()

dk_copy("${ios_cmake}/ios.toolchain.cmake" "$ENV{DKCMAKE_DIR}/ios.toolchain.cmake" OVERWRITE)
