if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/corefoundation

FIND_LIBRARY(CoreFoundation_lib CoreFoundation)
if(NOT CoreFoundation_lib)
	message(WARNING "Could not locate CoreFoundation framework")
endif()
APPLE_LIB(${CoreFoundation_lib})
