# https://developer.apple.com/documentation/UIKit
if(NOT IOS)
	return()
endif()


#DKIMPORT(UIKit)

FIND_LIBRARY(UIKit_lib UIKit)
if(NOT UIKit_lib)
	DKWARN("Could not locate UIKit framework")
endif()
APPLE_DKLIB(${UIKit_lib})
