# https://developer.apple.com/documentation/imageio

if(NOT MAC_HOST)
	dk_undepend(imageio)
	dk_return()
endif()


find_library(ImageIO_lib ImageIO)
if(NOT ImageIO_lib)
	dk_error("Could not locate ImageIO framework")
endif()
APPLE_dk_lib(${ImageIO_lib})
