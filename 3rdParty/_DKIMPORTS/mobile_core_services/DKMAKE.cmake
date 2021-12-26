if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/mobilecoreservices

FIND_LIBRARY(MobileCoreServices_lib MobileCoreServices)
if(NOT MobileCoreServices_lib)
	message(FATAL_ERROR "Could not locate MobileCoreServices framework")
endif()
APPLE_LIB(${MobileCoreServices_lib})
