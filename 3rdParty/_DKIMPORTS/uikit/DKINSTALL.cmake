#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ uikit ############
# https://developer.apple.com/documentation/UIKit

dk_load(dk_builder)

if(NOT IOS)
	dk_undepend(uikit)
	dk_return()
endif()

dk_findLibrary(UIKit)
