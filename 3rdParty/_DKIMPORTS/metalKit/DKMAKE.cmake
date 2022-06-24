# https://developer.apple.com/documentation/metal?language=objc

if(NOT MAC_HOST)
	return()
endif()

FIND_LIBRARY(MetalKit_lib MetalKit)
if(NOT MetalKit_lib)
	dk_error("Could not locate MetalKit framework")
endif()
APPLE_dk_lib(${MetalKit_lib})
