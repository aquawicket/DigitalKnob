# https://github.com/leetal/ios-cmake

dk_import(https://github.com/leetal/ios-cmake.git)
dk_copy(${IOS_CMAKE}/ios.toolchain.cmake ${DKCMAKE_DIR}/ios.toolchain.cmake OVERWRITE)
