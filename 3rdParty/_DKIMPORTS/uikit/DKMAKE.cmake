# https://developer.apple.com/documentation/UIKit
if(NOT IOS)
	return()
endif()


#dk_import(UIKit)

FIND_LIBRARY(UIKit_lib UIKit)
if(NOT UIKit_lib)
	DKWARN("Could not locate UIKit framework")
endif()
APPLE_dk_lib(${UIKit_lib})
