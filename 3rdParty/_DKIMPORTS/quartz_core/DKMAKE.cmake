# https://developer.apple.com/documentation/quartzcore
if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(QuartzCore_lib QuartzCore)
if(NOT QuartzCore_lib)
	dk_warn("Could not locate QuartzCore framework")
endif()
APPLE_dk_lib(${QuartzCore_lib})