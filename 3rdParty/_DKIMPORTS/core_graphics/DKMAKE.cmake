# https://developer.apple.com/documentation/coregraphics?language=objc

FIND_LIBRARY(core_graphics_lib CoreGraphics)
if(NOT ${coregraphics_lib})
	message(FATAL_ERROR "Could not locate CoreGraphics framework")
endif()
APPLE_LIB(${core_graphics_lib})
