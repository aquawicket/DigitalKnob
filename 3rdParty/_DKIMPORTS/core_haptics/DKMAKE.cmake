if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/corehaptics?language=objc

FIND_LIBRARY(CoreHaptics_lib CoreHaptics)
if(NOT CoreHaptics_lib)
	DKWARN("Could not locate CoreHaptics framework")
endif()
APPLE_DKLIB(${CoreHaptics_lib})
