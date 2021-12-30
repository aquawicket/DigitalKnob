if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/quartzcore

FIND_LIBRARY(QuartzCore_lib QuartzCore)
if(NOT QuartzCore_lib)
	DKWARN("Could not locate QuartzCore framework")
endif()
APPLE_DKLIB(${QuartzCore_lib})