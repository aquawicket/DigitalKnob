if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/gamecontroller?language=objc

FIND_LIBRARY(gameController_lib GameController)
if(NOT gameController_lib)
	message(WARNING "Could not locate GameController framework")
endif()
APPLE_LIB(${gameController_lib})
