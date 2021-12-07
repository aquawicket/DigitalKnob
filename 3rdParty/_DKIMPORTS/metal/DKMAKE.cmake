if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/metal?language=objc

FIND_LIBRARY(Metal_lib Metal)
if(NOT Metal_lib)
	message(FATAL_ERROR "Could not locate Metal framework")
endif()
APPLE_LIB(${Metal_lib})
