if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/mobilecoreservices

FIND_LIBRARY(mobile_core_services_lib MobileCoreServices)
APPLE_LIB(${mobile_core_services_lib})
