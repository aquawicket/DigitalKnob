if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/foundation?language=objc

FIND_LIBRARY(Foundation_lib Foundation)
if(NOT Foundation_lib)
	DKWARN("Could not location Foundation framework")
endif()
APPLE_DKLIB(${Foundation_lib})
