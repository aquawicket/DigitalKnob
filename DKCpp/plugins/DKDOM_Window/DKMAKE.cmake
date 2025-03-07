#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKDOM_Window ############
dk_depend(uriparser)
dk_depend(DKEventTarget)

dk_generateCmake(DKWindow)
dk_assets(DKWindow)