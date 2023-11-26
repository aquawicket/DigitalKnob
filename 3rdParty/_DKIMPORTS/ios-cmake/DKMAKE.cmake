# https://github.com/leetal/ios-cmake

dk_import(https://github.com/leetal/ios-cmake.git)
dk_copy(${IOS-CMAKE}/ios.toolchain.cmake ${DKCMAKE}/ios.toolchain.cmake OVERWRITE)
