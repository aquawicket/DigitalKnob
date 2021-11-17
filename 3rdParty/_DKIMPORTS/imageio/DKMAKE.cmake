if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/imageio

FIND_LIBRARY(ImageIO_lib ImageIO)
if(NOT ImageIO_lib)
	message(FATAL_ERROR "Could not locate ImageIO framework")
endif()
APPLE_LIB(${ImageIO_lib})
