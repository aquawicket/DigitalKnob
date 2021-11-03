# https://developer.apple.com/documentation/iokit

FIND_LIBRARY(iokit_lib IOKit)
if(NOT ${iokit_lib})
	#message(FATAL_ERROR "Could not locate IOKit framework")
endif()
APPLE_LIB(${iokit_lib})
