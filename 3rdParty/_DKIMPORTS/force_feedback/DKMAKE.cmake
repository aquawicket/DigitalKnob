# https://developer.apple.com/documentation/ForceFeedback

if(NOT MAC)
	return()
endif()


FIND_LIBRARY(ForceFeedback_lib ForceFeedback)
if(NOT ForceFeedback_lib)
	dk_error("Could not locate ForceFeedback framework")
endif()
APPLE_dk_lib(${ForceFeedback_lib})
