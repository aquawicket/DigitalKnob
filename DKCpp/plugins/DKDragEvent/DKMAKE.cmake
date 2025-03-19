#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKDragEvent ############
dk_depend(DK)
dk_depend(DKMouseEvent)

dk_generateCmake(DKDragEvent)
dk_assets(DKDragEvent)