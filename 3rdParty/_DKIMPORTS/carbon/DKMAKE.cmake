# https://developer.apple.com/documentation/coreservices/carbon_core

if(NOT MAC)
	return()
endif()


FIND_LIBRARY(Carbon_lib Carbon)
if(NOT Carbon_lib)
	dk_error("Could not locate Carbon framework")
endif()
APPLE_dk_lib(${Carbon_lib})
