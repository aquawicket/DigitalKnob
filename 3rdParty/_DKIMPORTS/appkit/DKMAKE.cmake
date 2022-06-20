# https://developer.apple.com/documentation/appkit
if(NOT MAC)
	return()
endif()

FIND_LIBRARY(appkit_lib AppKit)
if(NOT appkit_lib)
	dk_warn("Could not locate AppKit framework")
endif()
APPLE_dk_lib(${appkit_lib})
