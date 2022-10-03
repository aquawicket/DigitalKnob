# https://developer.apple.com/documentation/gamecontroller?language=objc

if(NOT MAC_HOST)
	return()
endif()


dk_findLibrary(GameController)
