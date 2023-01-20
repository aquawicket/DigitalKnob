if(NOT MAC_HOST)
	dk_undepend(metal-cpp)
	dk_return()
endif()

# https://developer.apple.com/metal/cpp/
# https://developer.apple.com/metal/cpp/files/metal-cpp_macOS12_iOS15.zip

### VERSION ###
dk_set(METALCPP_FOLDER metal-cpp_macOS12_iOS15)
dk_set(METALCPP_DL https://developer.apple.com/metal/cpp/files/metal-cpp_macOS12_iOS15.zip)
dk_set(METALCPP ${3RDPARTY}/${METALCPP_FOLDER})


### INSTALL ###
#dk_install(${METALCPP_DL} ${METALCPP})
dk_import(${METALCPP_DL} ${METALCPP})

dk_include(${METALCPP})
