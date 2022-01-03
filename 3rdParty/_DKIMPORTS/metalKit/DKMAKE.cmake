if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/metal?language=objc

FIND_LIBRARY(MetalKit_lib MetalKit)
if(NOT MetalKit_lib)
	DKWARN("Could not locate MetalKit framework")
endif()
APPLE_DKLIB(${MetalKit_lib})
