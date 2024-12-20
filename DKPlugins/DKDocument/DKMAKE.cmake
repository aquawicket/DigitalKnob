#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKDocument ############
dk_depend(DKNode)
dk_depend(DKNonElementParentNode)	# mixin
dk_depend(DKHTMLCollection)
dk_depend(DKElement)


dk_generateCmake(DKDocument)
dk_assets(DKDocument)