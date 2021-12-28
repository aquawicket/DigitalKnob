if(NOT MAC)
	return()
endif()

# https://developer.apple.com/documentation/ForceFeedback

FIND_LIBRARY(ForceFeedback_lib ForceFeedback)
if(NOT ForceFeedback_lib)
	message(WARNING "Could not locate ForceFeedback framework")
endif()
APPLE_DKLIB(${ForceFeedback_lib})
