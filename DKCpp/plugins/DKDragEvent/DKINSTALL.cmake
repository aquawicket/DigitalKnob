#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKDragEvent ############
dk_depend(DK)
dk_depend(DKMouseEvent)




############ DKDragEvent ############
dk_set(CURRENT_PLUGIN "DKDragEvent")
dk_generateCmake(DKDragEvent)
dk_assets(DKDragEvent)
dk_set(DKDragEvent "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKDragEvent")
dk_configure(${DKDragEvent})
dk_build(${DKDragEvent})