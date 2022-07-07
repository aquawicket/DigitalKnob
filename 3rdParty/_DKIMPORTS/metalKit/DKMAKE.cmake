# https://developer.apple.com/documentation/metal?language=objc

if(NOT MAC_HOST)
	return()
endif()

dk_findLibrary(MetalKit)
