#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKCSSStyleDeclaration ############
# [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
dk_depend(DKInterface)

dk_generateCmake(DKCSSStyleDeclaration)
dk_assets(DKCSSStyleDeclaration)