if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/metal/cpp/
# https://developer.apple.com/metal/cpp/files/metal-cpp_macOS12_iOS15.zip

### VERSION ###
DKSET(METALCPP_NAME metal-cpp_macOS12_iOS15)
DKSET(METALCPP_DL https://developer.apple.com/metal/cpp/files/metal-cpp_macOS12_iOS15.zip)
DKSET(METALCPP ${3RDPARTY}/${METALCPP_NAME})


### INSTALL ###
DKINSTALL(${METALCPP_DL} metal-cpp ${METALCPP})

DKINCLUDE(${METALCPP}/metal-cpp)