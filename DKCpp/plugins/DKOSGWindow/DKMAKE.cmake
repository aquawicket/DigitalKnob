#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKOSGWindow ############
dk_depend(DKAssets)
dk_depend(DKOSGViewer)
dk_depend(DKWindow)

dk_generateCmake(DKOSGWindow)
