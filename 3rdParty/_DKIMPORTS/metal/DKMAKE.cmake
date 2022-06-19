if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/metal?language=objc

FIND_LIBRARY(Metal_lib Metal)
if(NOT Metal_lib)
	DKWARN("Could not locate Metal framework")
endif()
APPLE_dk_lib(${Metal_lib})
