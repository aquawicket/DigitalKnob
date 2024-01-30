if(NOT MAC_HOST)
	dk_undepend(metal-cpp)
	dk_return()
endif()

# https://developer.apple.com/metal/cpp/
# https://developer.apple.com/metal/cpp/files/metal-cpp_macOS12_iOS15.zip

### VERSION ###
dk_set(METAL_CPP_FOLDER metal-cpp_macOS12_iOS15)
dk_set(METAL_CPP_DL https://developer.apple.com/metal/cpp/files/metal-cpp_macOS12_iOS15.zip)
dk_set(METAL_CPP ${3RDPARTY}/${METAL_CPP_FOLDER})


### INSTALL ###
dk_import(${METAL_CPP_DL} ${METAL_CPP})

dk_include(${METAL_CPP})
