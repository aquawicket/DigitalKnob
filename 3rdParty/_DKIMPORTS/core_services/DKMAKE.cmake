if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/coregraphics?language=objc

FIND_LIBRARY(CoreServices_lib CoreServices)
if(NOT CoreServices_lib)
	message(WARNING "Could not locate CoreServices framework")
endif()
APPLE_LIB(${CoreServices_lib})
