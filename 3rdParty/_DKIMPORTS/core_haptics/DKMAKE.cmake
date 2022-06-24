# https://developer.apple.com/documentation/corehaptics?language=objc

if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(CoreHaptics_lib CoreHaptics)
if(NOT CoreHaptics_lib)
	dk_error("Could not locate CoreHaptics framework")
endif()
APPLE_dk_lib(${CoreHaptics_lib})
