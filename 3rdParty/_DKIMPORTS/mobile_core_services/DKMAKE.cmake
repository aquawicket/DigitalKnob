if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/mobilecoreservices

FIND_LIBRARY(mobile_core_services_lib MobileCoreServices)
if(NOT mobile_core_services_lib)
	message(FATAL_ERROR "Could not locate MobileCoreServices framework")
endif()
APPLE_LIB(${mobile_core_services_lib})
