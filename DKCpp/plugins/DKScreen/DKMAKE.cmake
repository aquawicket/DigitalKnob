#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKScreen ############
#dk_depend(libx11-dev)	# XOpenDisplay()

dk_depend(DKInterface)

dk_generateCmake(DKScreen)
dk_assets(DKScreen)
