#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKKeyboardEvent ############
dk_depend(DK)
dk_depend(DKUIEvent)
dk_generateCmake(DKKeyboardEvent)
dk_assets(DKKeyboardEvent)