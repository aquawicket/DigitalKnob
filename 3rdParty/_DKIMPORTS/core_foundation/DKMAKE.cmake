# https://developer.apple.com/documentation/corefoundation

FIND_LIBRARY(corefoundation_lib CoreFoundation)
if(NOT ${corefoundation_lib})
	#message(FATAL_ERROR "Could not locate CoreFoundation framework")
endif()
APPLE_LIB(${corefoundation_lib})
