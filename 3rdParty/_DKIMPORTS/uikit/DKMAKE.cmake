if(NOT IOS)
	return()
endif()

# https://developer.apple.com/documentation/UIKit

FIND_LIBRARY(UIKit_lib UIKit)
if(NOT UIKit_lib)
	message(FATAL_ERROR "Could not locate UIKit framework")
endif()
APPLE_LIB(${UIKit_lib})
