#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/leetal/ios-cmake

dk_import(https://github.com/leetal/ios-cmake/archive/ad96a372b168930c2a1ff9455e1a9ccb13021617.zip)
#dk_import(https://github.com/leetal/ios-cmake/archive/refs/heads/master.zip)
dk_copy(${IOS_CMAKE}/ios.toolchain.cmake ${DKCMAKE_DIR}/ios.toolchain.cmake OVERWRITE)
