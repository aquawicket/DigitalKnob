#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
if(NOT MAC_HOST)
	dk_undepend(metal-cpp)
	dk_return()
endif()

# https://developer.apple.com/metal/cpp/
# https://developer.apple.com/metal/cpp/files/metal-cpp_macOS12_iOS15.zip

### VERSION ###
dk_set(METAL_CPP_FOLDER metal-cpp_macOS12_iOS15)
dk_set(METAL_CPP_DL https://developer.apple.com/metal/cpp/files/metal-cpp_macOS12_iOS15.zip)
dk_set(METAL_CPP ${DK3RDPARTY_DIR}/${METAL_CPP_FOLDER})


### INSTALL ###
dk_import(${METAL_CPP_DL} ${METAL_CPP})

dk_include(${METAL_CPP})
