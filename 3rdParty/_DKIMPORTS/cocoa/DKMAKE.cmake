# https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/WhatIsCocoa/WhatIsCocoa.html
if(NOT MAC)
	return()
endif()


FIND_LIBRARY(Cocoa_lib Cocoa)
if(NOT Cocoa_lib)
	dk_warn("Could not locate Cocoa framework")
endif()
APPLE_dk_lib(${Cocoa_lib})
