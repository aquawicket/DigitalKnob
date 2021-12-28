if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/IOKit

FIND_LIBRARY(IOKit_lib IOKit)
if(NOT IOKit_lib)
	message(WARNING "Could not locate IOKit framework")
endif()
APPLE_DKLIB(${IOKit_lib})
