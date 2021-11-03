# https://developer.apple.com/documentation/appkit

FIND_LIBRARY(appkit_lib AppKit)
if(NOT ${appkit_lib})
	message(FATAL_ERROR "Could not locate AppKit framework")
endif()
APPLE_LIB(${appkit_lib})
