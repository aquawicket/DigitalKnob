# https://developer.apple.com/documentation/corefoundation
if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(CoreFoundation_lib CoreFoundation)
if(NOT CoreFoundation_lib)
	DKWARN("Could not locate CoreFoundation framework")
endif()
APPLE_DKLIB(${CoreFoundation_lib})
