# https://developer.apple.com/documentation/gamecontroller?language=objc

if(NOT APPLE)
	dk_undepend(game_controller)
	dk_return()
endif()


dk_findLibrary(GameController)
