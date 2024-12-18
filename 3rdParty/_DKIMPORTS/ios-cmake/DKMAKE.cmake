#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ ios-cmake ############
# https://github.com/leetal/ios-cmake
dk_load(dk_builder)

dk_import(https://github.com/leetal/ios-cmake/archive/ad96a372.zip)

dk_copy(${IOS_CMAKE}/ios.toolchain.cmake ${DKCMAKE_DIR}/ios.toolchain.cmake OVERWRITE)
