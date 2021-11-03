# https://developer.apple.com/documentation/uikit

FIND_LIBRARY(uikit_lib UIKit)
if(NOT ${uikit_lib})
	message(FATAL_ERROR "Could not locate UIKit framework")
endif()
APPLE_LIB(${uikit_lib})
