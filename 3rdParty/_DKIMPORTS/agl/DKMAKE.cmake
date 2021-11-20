if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/agl/agl

FIND_LIBRARY(AGL_Lib AGL)
if(NOT AGL_Lib)
	message(FATAL_ERROR "Could not locate AGL framework")
endif()
APPLE_LIB(${AGL_Lib})
