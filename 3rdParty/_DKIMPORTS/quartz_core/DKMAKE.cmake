if(NOT MAC)
	return()
endif()

# https://developer.apple.com/documentation/quartzcore

FIND_LIBRARY(QuartzCore_lib QuartzCore)
if(NOT QuartzCore_lib)
	message(FATAL_ERROR "Could not locate QuartzCore framework")
endif()
APPLE_LIB(${QuartzCore_lib})