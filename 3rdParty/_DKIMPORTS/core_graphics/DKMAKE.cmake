# https://developer.apple.com/documentation/coregraphics?language=objc

if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(CoreGraphics_lib CoreGraphics)
if(NOT CoreGraphics_lib)
	dk_error("Could not locate CoreGraphics framework")
endif()
APPLE_dk_lib(${CoreGraphics_lib})
