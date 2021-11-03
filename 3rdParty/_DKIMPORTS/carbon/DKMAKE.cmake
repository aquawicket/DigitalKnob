# https://developer.apple.com/documentation/coreservices/carbon_core

FIND_LIBRARY(carbon_lib Carbon)
if(NOT ${carbon_lib})
	message(FATAL_ERROR "Could not locate Carbon framework")
endif()
APPLE_LIB(${carbon_lib})