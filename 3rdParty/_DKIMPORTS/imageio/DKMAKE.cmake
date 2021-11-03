# https://developer.apple.com/documentation/imageio

FIND_LIBRARY(imageio_lib ImageIO)
if(NOT ${imageio_lib})
	message(FATAL_ERROR "Could not locate ImageIO framework")
endif()
APPLE_LIB(${imageio_lib})
