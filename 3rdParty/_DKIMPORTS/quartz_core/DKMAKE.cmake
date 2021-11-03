# https://developer.apple.com/documentation/quartzcore

FIND_LIBRARY(quartz_core_lib QuartzCore)
if(NOT ${quartz_core_lib})
	message(FATAL_ERROR "Could not locate QuartzCore framework")
endif()
APPLE_LIB(${quartz_core_lib_lib})
