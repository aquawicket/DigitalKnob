if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/IOKit

FIND_LIBRARY(IOKit_lib IOKit)
if(NOT IOKit_lib)
	message(FATAL_ERROR "Could not locate IOKit framework")
endif()
APPLE_LIB(${IOKit_lib})
