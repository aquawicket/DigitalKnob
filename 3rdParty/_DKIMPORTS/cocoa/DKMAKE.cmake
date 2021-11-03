# https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/WhatIsCocoa/WhatIsCocoa.html

FIND_LIBRARY(cocoa_lib Cocoa)
if(NOT ${cocoa_lib})
	message(FATAL_ERROR "Could not locate Cocoa framework")
endif()
APPLE_LIB(${cocoa_lib})
