#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKRmlElementCSSInlineStyle ############
dk_depend(DKElementCSSInlineStyle)

dk_generateCmake(DKRmlElementCSSInlineStyle)
dk_assets(DKRmlElementCSSInlineStyle)