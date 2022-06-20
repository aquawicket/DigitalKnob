if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/imageio

FIND_LIBRARY(ImageIO_lib ImageIO)
if(NOT ImageIO_lib)
	dk_warn("Could not locate ImageIO framework")
endif()
APPLE_dk_lib(${ImageIO_lib})
