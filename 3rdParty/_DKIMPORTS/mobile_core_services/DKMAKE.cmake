# https://developer.apple.com/documentation/mobilecoreservices

if(NOT MAC_HOST)
	return()
endif()

FIND_LIBRARY(MobileCoreServices_lib MobileCoreServices)
if(NOT MobileCoreServices_lib)
	dk_error("Could not locate MobileCoreServices framework")
endif()
APPLE_dk_lib(${MobileCoreServices_lib})
