if(NOT MAC)
	return()
endif()

# https://developer.apple.com/documentation/appkit

FIND_LIBRARY(appkit_lib AppKit)
if(NOT appkit_lib)
	message(WARNING "Could not locate AppKit framework")
endif()
APPLE_DKLIB(${appkit_lib})
