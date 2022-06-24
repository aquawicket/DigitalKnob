# https://developer.apple.com/documentation/foundation?language=objc

if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(Foundation_lib Foundation)
if(NOT Foundation_lib)
	dk_error("Could not location Foundation framework")
endif()
APPLE_dk_lib(${Foundation_lib})
