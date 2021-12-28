if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/metal?language=objc

FIND_LIBRARY(Metal_lib Metal)
if(NOT Metal_lib)
	message(WARNING "Could not locate Metal framework")
endif()
APPLE_DKLIB(${Metal_lib})
