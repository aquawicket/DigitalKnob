if(NOT MAC)
	return()
endif()

# https://developer.apple.com/documentation/coreservices/carbon_core

FIND_LIBRARY(Carbon_lib Carbon)
if(NOT Carbon_lib)
	message(WARNING "Could not locate Carbon framework")
endif()
APPLE_DKLIB(${Carbon_lib})