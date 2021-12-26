if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/corevideo

FIND_LIBRARY(CoreVideo_lib CoreVideo)
if(NOT CoreVideo_lib)
	message(FATAL_ERROR "Could not locate CoreVideo framework")
endif()
APPLE_LIB(${CoreVideo_lib})
