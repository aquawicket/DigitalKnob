# https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/WhatIsCocoa/WhatIsCocoa.html

if(NOT APPLE)
	dk_return()
endif()

dk_findLibrary(Cocoa)
