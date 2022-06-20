if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/IOKit

FIND_LIBRARY(IOKit_lib IOKit)
if(NOT IOKit_lib)
	dk_warn("Could not locate IOKit framework")
endif()
APPLE_dk_lib(${IOKit_lib})
