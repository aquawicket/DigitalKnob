#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
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
