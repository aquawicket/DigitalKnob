if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/metal?language=objc

FIND_LIBRARY(MetalKit_lib MetalKit)
if(NOT MetalKit_lib)
	message(WARNING "Could not locate MetalKit framework")
endif()
APPLE_LIB(${MetalKit_lib})
