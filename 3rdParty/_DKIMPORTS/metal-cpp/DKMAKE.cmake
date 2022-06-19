if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/metal/cpp/
# https://developer.apple.com/metal/cpp/files/metal-cpp_macOS12_iOS15.zip

### VERSION ###
dk_set(METALCPP_NAME metal-cpp_macOS12_iOS15)
dk_set(METALCPP_DL https://developer.apple.com/metal/cpp/files/metal-cpp_macOS12_iOS15.zip)
dk_set(METALCPP ${3RDPARTY}/${METALCPP_NAME})


### INSTALL ###
dk_install(${METALCPP_DL} metal-cpp ${METALCPP})

dk_include(${METALCPP})