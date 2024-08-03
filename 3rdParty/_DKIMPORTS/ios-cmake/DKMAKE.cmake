include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/leetal/ios-cmake

#dk_import(https://github.com/leetal/ios-cmake.git)
dk_import(https://github.com/leetal/ios-cmake/archive/refs/heads/master.zip)
dk_copy(${IOS_CMAKE}/ios.toolchain.cmake ${DKCMAKE_DIR}/ios.toolchain.cmake OVERWRITE)
