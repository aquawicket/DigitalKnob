#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ carbon ############
# https://developer.apple.com/documentation/coreservices/carbon_core?language=objc


if(NOT MAC)
	dk_undepend(carbon)
	dk_return()
endif()

dk_findLibrary(Carbon)
