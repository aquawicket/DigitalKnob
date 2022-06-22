# https://developer.apple.com/documentation/metal?language=objc

if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(Metal_lib Metal)
if(NOT Metal_lib)
	dk_error("Could not locate Metal framework")
endif()
APPLE_dk_lib(${Metal_lib})
