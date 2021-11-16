if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/gamecontroller?language=objc

FIND_LIBRARY(gameController_lib GameController)
if(NOT gameController_lib)
	message(FATAL_ERROR "Could not locate GameController framework")
endif()
APPLE_LIB(${gameController_lib})
