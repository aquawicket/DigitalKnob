# https://developer.apple.com/documentation/IOKit

if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(IOKit_lib IOKit)
if(NOT IOKit_lib)
	dk_error("Could not locate IOKit framework")
endif()
APPLE_dk_lib(${IOKit_lib})
