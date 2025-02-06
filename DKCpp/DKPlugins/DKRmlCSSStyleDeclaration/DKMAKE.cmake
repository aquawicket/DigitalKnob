#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKRmlCSSStyleDeclaration ############
# [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
dk_depend(DKCSSStyleDeclaration)

dk_generateCmake(DKRmlCSSStyleDeclaration)
dk_assets(DKRmlCSSStyleDeclaration)