# https://developer.apple.com/documentation/corevideo
if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(CoreVideo_lib CoreVideo)
if(NOT CoreVideo_lib)
	DKWARN("Could not locate CoreVideo framework")
endif()
APPLE_DKLIB(${CoreVideo_lib})
