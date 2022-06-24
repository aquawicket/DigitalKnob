# https://developer.apple.com/documentation/imageio

if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(ImageIO_lib ImageIO)
if(NOT ImageIO_lib)
	dk_error("Could not locate ImageIO framework")
endif()
APPLE_dk_lib(${ImageIO_lib})
