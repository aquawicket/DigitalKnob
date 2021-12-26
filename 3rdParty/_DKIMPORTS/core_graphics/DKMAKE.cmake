if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/coregraphics?language=objc

FIND_LIBRARY(CoreGraphics_lib CoreGraphics)
if(NOT CoreGraphics_lib)
	message(FATAL_ERROR "Could not locate CoreGraphics framework")
endif()
APPLE_LIB(${CoreGraphics_lib})
