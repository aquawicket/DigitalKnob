#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ game_controller ############
# https://developer.apple.com/documentation/gamecontroller?language=objc
dk_load(dk_builder)
if(NOT APPLE)
	dk_undepend(game_controller)
	dk_return()
endif()

dk_findLibrary(GameController)
