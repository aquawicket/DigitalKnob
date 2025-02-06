#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKElementCSSInlineStyle ############
dk_depend(DKInterface)

dk_generateCmake(DKElementCSSInlineStyle)
dk_assets(DKElementCSSInlineStyle)