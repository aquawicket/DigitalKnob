#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKRmlNonElementParentNode ############
dk_depend(DKNonElementParentNode)

dk_generateCmake(DKRmlNonElementParentNode)
dk_assets(DKRmlNonElementParentNode)