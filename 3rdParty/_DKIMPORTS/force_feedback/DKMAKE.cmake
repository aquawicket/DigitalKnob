# https://developer.apple.com/documentation/forcefeedback

FIND_LIBRARY(forcefeedback_lib ForceFeedback)
if(NOT ${forcefeedback_lib})
	message(FATAL_ERROR "Could not locate ForceFeedback framework")
endif()
APPLE_LIB(${forcefeedback_lib})
