if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/mobilecoreservices

FIND_LIBRARY(MobileCoreServices_lib MobileCoreServices)
if(NOT MobileCoreServices_lib)
	dk_warn("Could not locate MobileCoreServices framework")
endif()
APPLE_dk_lib(${MobileCoreServices_lib})
