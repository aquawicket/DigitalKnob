#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKRmlEventListener ############
dk_depend(DKEventListener)
dk_depend(DKRmlInterface)

dk_generateCmake(DKRmlEventListener)
dk_assets(DKRmlEventListener)
