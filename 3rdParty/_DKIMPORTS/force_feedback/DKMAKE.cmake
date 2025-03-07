#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ force_feedback ############
# https://developer.apple.com/documentation/ForceFeedback

dk_load(dk_builder)
if(NOT MAC)
	dk_undepend(force_feedback)
	dk_return()
endif()

dk_findLibrary(ForceFeedback)
