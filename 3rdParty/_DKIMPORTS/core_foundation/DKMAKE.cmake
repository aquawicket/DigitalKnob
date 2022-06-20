# https://developer.apple.com/documentation/corefoundation
if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(CoreFoundation_lib CoreFoundation)
if(NOT CoreFoundation_lib)
	dk_warn("Could not locate CoreFoundation framework")
endif()
APPLE_dk_lib(${CoreFoundation_lib})
