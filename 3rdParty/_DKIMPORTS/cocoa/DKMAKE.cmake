if(NOT MAC)
	return()
endif()

# https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/WhatIsCocoa/WhatIsCocoa.html

FIND_LIBRARY(Cocoa_lib Cocoa)
if(NOT Cocoa_lib)
	DKWARN("Could not locate Cocoa framework")
endif()
APPLE_DKLIB(${Cocoa_lib})
